//
//  MealPlanStore.swift
//  Cleanse App
//
//  Created by Erik Karlsson on 6/26/16.
//  Copyright © 2016 Nano Nimbus. All rights reserved.
//

import UIKit

enum ImageResult {
    case Success(UIImage)
    case Failure(ErrorType)
}

enum PhotoError: ErrorType {
    case ImageCreationError
}

class MealPlanStore: NSObject {
    
    // Singleton of the MealPlanStore
    static let sharedInstance = MealPlanStore()
    
    // Singleton of the Current meal plan
    static var currentMealPlan = MealPlan()
    
    // Static variable to determine if the first plan has been downloaded.
    static var plansReceived = false
    
    // Stores the day that the user is currently on
    static var currentDay = 1
    
    // Stores the starting date
    static var startingDate = NSDate()
    
    var counter = 0
    
    static var imagesFinishedDownloadSet = Set<Int>()
    
    // This is the path to where the information for the meal plans are stored.
    let mealPlanArchiveURL: NSURL = {
        let documentsDirectories =
            NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.URLByAppendingPathComponent("mealplans.archive")!
    }()

    // URLSession configuration for accessing online web services.
    let session: NSURLSession = {
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        return NSURLSession(configuration: config)
    }()
    
    // MARK: Retrieval Methods
    func fetchMealPlans(completion completion: (MealPlanResult) -> Void) {
        let url = DeploydAPI.mealPlansURL()
        let request = NSURLRequest(URL:url)
        let task = session.dataTaskWithRequest(request) {
            (data, response, error) -> Void in
            
            let result = self.processRecentMealPlansRequest(data: data, error: error)
            completion(result)
        }
        task.resume()
    }

    /*
    Method for retrieving the photo from URL in the given Meal
     */
    func fetchImageForPhoto(meal: Meal, completion: (ImageResult) -> Void){
        
        if let photoURL = meal.recipe?.imageURL {
            var tmpCount: Int
            let request = NSURLRequest(URL:photoURL)
            print("Image starting download \(counter)...")
            tmpCount = counter
            MealPlanStore.imagesFinishedDownloadSet.insert(counter)
            let task = session.dataTaskWithRequest(request){
                (data, response, error) -> Void in
                if let imageData = data as NSData? {
                    meal.recipe?.image = UIImage(data: imageData)!
                    print("Image done downloading \(tmpCount)")
                    MealPlanStore.imagesFinishedDownloadSet.remove(tmpCount)
                }
            }
            counter += 1
            task.resume()
        }
    }
    
    // MARK: Processing Methods
    func processRecentMealPlansRequest(data data: NSData?, error: NSError?) -> MealPlanResult {
        guard let jsonData = data else {
            return .Failure(error!)
        }
        return DeploydAPI.mealPlansFromJSONData(jsonData)
    }
    
    /*
     Initializes the meal plan and loads the images dynamically.
     */
    func initMealPlan(user:User){
        loadMealPlanFromArchive(user)
        if !MealPlanStore.plansReceived {
            // Attempt to fetch the Meal Plans
            fetchMealPlans(){
                (mealPlanResult) -> Void in
                
                switch mealPlanResult {
                case let .Success(mealPlan):
                    
                    // If the plan was recevied successfully then
                    MealPlanStore.plansReceived = true

                    MealPlanStore.currentMealPlan = mealPlan[0] as! MealPlan
                    for day in MealPlanStore.currentMealPlan.days {
                        if let plan = day as? DailyPlan {
                            for meal in plan.meals {
                                self.fetchImageForPhoto(meal as! Meal) {
                                    (imageResult) -> Void in
                                    switch imageResult {
                                    case .Success(_):
                                        print("Downloaded the image")
                                    case .Failure(_):
                                        print("Error downloading the image")
                                    }
                                }
                            }
                        }
                    }
                    user.setPlanState(true)
                case let .Failure(error):
                    print("Error fetching meal plan: \(error)")
                    MealPlanStore.plansReceived = false
                }
            }
        }
    }

    // MARK: - Persistence
    // Method will check if the given user has a meal plan, and if they do, try to load the file.
    func loadMealPlanFromArchive(user:User) -> Bool {
        if user.hasPlan() {
            if let archivedItems = NSKeyedUnarchiver.unarchiveObjectWithFile(mealPlanArchiveURL.path!) as? MealPlan {
                MealPlanStore.currentMealPlan = archivedItems
                MealPlanStore.plansReceived = true
                print("Successfully unarchived plans")
            } else {
                MealPlanStore.plansReceived = false
                print("Failed to unarchive plans")
            }
        }
        return MealPlanStore.plansReceived
    }
    
    func saveChanges() -> Bool {
        print("Saving meal plan to \(mealPlanArchiveURL.path!)")
        return NSKeyedArchiver.archiveRootObject(MealPlanStore.currentMealPlan, toFile: mealPlanArchiveURL.path!)
    }
 
}
