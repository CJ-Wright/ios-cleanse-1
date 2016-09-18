//
//  MealPlanStore.swift
//  Cleanse App
//
//  Created by Erik Karlsson on 6/26/16.
//  Copyright © 2016 Nano Nimbus. All rights reserved.
//

import UIKit

enum ImageResult {
    case success(UIImage)
    case failure(Error)
}

enum PhotoError: Error {
    case imageCreationError
}

class MealPlanStore: NSObject {
    
    // Singleton of the MealPlanStore
    static let sharedInstance = MealPlanStore()
    
    // Singleton of the Current meal plan
    static var currentMealPlan = MealPlan()
    
    // Static variable to determine if the first plan has been downloaded.
    static var plansReceived = false
    
    var counter = 0
    
    // This is the path to where the information for the meal plans are stored.
    let mealPlanArchiveURL: URL = {
        let documentsDirectories =
            FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("mealplans.archive")
    }()

    // URLSession configuration for accessing online web services.
    let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    // MARK: Retrieval Methods
    func fetchMealPlans(completion: @escaping (MealPlanResult) -> Void) {
        let url = DeploydAPI.mealPlansURL()
        let request = URLRequest(url:url as URL)
        let task = session.dataTask(with: request, completionHandler: {
            (data, response, error) -> Void in
            
            let result = self.processRecentMealPlansRequest(data: data, error: error as NSError?)
            completion(result)
        }) 
        task.resume()
    }

    /*
    Method for retrieving the photo from URL in the given Meal
     */
    func fetchImageForPhoto(_ meal: Meal, completion: (ImageResult) -> Void){
        
        if let photoURL = meal.recipe?.imageURL {
            var tmpCount: Int
            let request = URLRequest(url:photoURL as URL)
            print("Image starting download \(counter)...")
            tmpCount = counter
            let task = session.dataTask(with: request, completionHandler: {
                (data, response, error) -> Void in
                if let imageData = data as Data? {
                    meal.recipe?.image = UIImage(data: imageData)!
                    print("Image done downloading \(tmpCount)")
                }
            })
            counter += 1
            task.resume()
        }
    }
    
    // MARK: Processing Methods
    func processRecentMealPlansRequest(data: Data?, error: NSError?) -> MealPlanResult {
        guard let jsonData = data else {
            return .failure(error!)
        }
        return DeploydAPI.mealPlansFromJSONData(jsonData)
    }
    
    /*
     Initializes the meal plan and loads the images dynamically.
     */
    func initMealPlan(_ user:User){
        loadMealPlanFromArchive(user)
        if !MealPlanStore.plansReceived {
            // Attempt to fetch the Meal Plans
            fetchMealPlans(){
                (mealPlanResult) -> Void in
                
                switch mealPlanResult {
                case let .success(mealPlan):
                    
                    // If the plan was recevied successfully then
                    MealPlanStore.plansReceived = true

                    MealPlanStore.currentMealPlan = mealPlan[0] as! MealPlan
                    for day in MealPlanStore.currentMealPlan.days {
                        if let plan = day as? DailyPlan {
                            for meal in plan.meals {
                                self.fetchImageForPhoto(meal as! Meal) {
                                    (imageResult) -> Void in
                                    switch imageResult {
                                    case .success(_):
                                        print("Downloaded the image")
                                    case .failure(_):
                                        print("Error downloading the image")
                                    }
                                }
                            }
                        }
                    }
                    user.setPlanState(true)
                case let .failure(error):
                    print("Error fetching meal plan: \(error)")
                    MealPlanStore.plansReceived = false
                }
            }
        }
    }

    // MARK: - Persistence
    // Method will check if the given user has a meal plan, and if they do, try to load the file.
    func loadMealPlanFromArchive(_ user:User) -> Bool {
        if user.hasPlan() {
            if let archivedItems = NSKeyedUnarchiver.unarchiveObject(withFile: mealPlanArchiveURL.path) as? MealPlan {
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
        print("Saving meal plan to \(mealPlanArchiveURL.path)")
        return NSKeyedArchiver.archiveRootObject(MealPlanStore.currentMealPlan, toFile: mealPlanArchiveURL.path)
    }
 
}
