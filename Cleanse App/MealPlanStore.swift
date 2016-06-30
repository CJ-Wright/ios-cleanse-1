//
//  MealPlanStore.swift
//  Cleanse App
//
//  Created by Erik Karlsson on 6/26/16.
//  Copyright © 2016 Nano Nimbus. All rights reserved.
//

import UIKit

class MealPlanStore: NSObject {
    
    // Singleton of the MealPlanStore
    static let sharedInstance = MealPlanStore()
    
    // TODO: Definitely needs to be considered for refactoring
    static var currentMealPlan = MealPlan()

    
//    static var currentMealPlan : MealPlan {
//        if _currentMealPlan == nil {
//            _currentMealPlan = MealPlan()
//            
//            MealPlanStore.sharedInstance.fetchMealPlans(){
//                (mealPlanResult) -> Void in
//                
//                switch mealPlanResult {
//                case let .Success(mealPlan):
//                    
//                    MealPlanStore.plansReceived = true
//                    // TODO: Need to implement a way to determine which plan the user is currently on
//                    _currentMealPlan = mealPlan[0] as? MealPlan
//                    
//                case let .Failure(error):
//                    print("Error fetching recipes: \(error)")
//                    MealPlanStore.plansReceived = false
//                }
//            }
//        }
//        return _currentMealPlan!
//    }
    static var plansReceived = false
    
    let session: NSURLSession = {
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        return NSURLSession(configuration: config)
    }()
    
    func fetchMealPlans(completion completion: (MealPlanResult) -> Void) {
        let url = DeploydAPI.mealPlansURL()
//        print(url)
        let request = NSURLRequest(URL:url)
//        print(request)
        let task = session.dataTaskWithRequest(request) {
            (data, response, error) -> Void in
            
            let result = self.processRecentMealPlansRequest(data: data, error: error)
            completion(result)
        }
        task.resume()
    }
    
    func processRecentMealPlansRequest(data data: NSData?, error: NSError?) -> MealPlanResult {
        guard let jsonData = data else {
            return .Failure(error!)
        }
        return DeploydAPI.mealPlansFromJSONData(jsonData)
    }
    
    func displayMealPlan(){
        print("Plan Name [ \(MealPlanStore.currentMealPlan.mealPlanName) ]")
        
        for dailyPlan in MealPlanStore.currentMealPlan.days {
            if let plan = dailyPlan as? DailyPlan {
                print("Day [\(plan.dayNumber)]")
                for meal in plan.meals! {
                    print("Meal [\(meal.mealName)] at [\(meal.mealTime)]")
                }
            }
        }
    }
    
    func initMealPlan(){
        if !MealPlanStore.plansReceived {
            // Attempt to fetch the Meal Plans
            fetchMealPlans(){
                (mealPlanResult) -> Void in
                
                switch mealPlanResult {
                case let .Success(mealPlan):
                    
                    MealPlanStore.plansReceived = true
                    // TODO: Need to implement a way to determine which plan the user is currently on
                    MealPlanStore.currentMealPlan = mealPlan[0] as! MealPlan
                    
                case let .Failure(error):
                    print("Error fetching recipes: \(error)")
                    MealPlanStore.plansReceived = false
                }
            }
        }
    }
 
}
