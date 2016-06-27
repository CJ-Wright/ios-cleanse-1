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
    static var currentMealPlan = MealPlan() // <- This may need to be changed to let
    static var plansReceived = false
    
    let session: NSURLSession = {
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        return NSURLSession(configuration: config)
    }()
    
    func fetchMealPlans(completion completion: (MealPlanResult) -> Void) {
        let url = DeploydAPI.mealPlansURL()
        print(url)
        let request = NSURLRequest(URL:url)
        print(request)
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
}
