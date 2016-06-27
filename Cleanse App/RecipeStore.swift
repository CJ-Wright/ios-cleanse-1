//
//  RecipeStore.swift
//  Cleanse App
//
//  Created by Erik Karlsson on 6/2/16.
//  Copyright © 2016 Nano Nimbus. All rights reserved.
//

import UIKit

class RecipeStore: NSObject {
    let session: NSURLSession = {
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        return NSURLSession(configuration: config)
    }()
    
//    func fetchRecipes() {
    func fetchRecipes(completion completion: (RecipeResult) -> Void) {
        let url = DeploydAPI.recipesURL()
        print(url)
        let request = NSURLRequest(URL:url)
        print(request)
        let task = session.dataTaskWithRequest(request) {
            (data, response, error) -> Void in
            
            
                let result = self.processRecentRecipesRequest(data: data, error: error)
            completion(result)
//            if let jsonData = data {
//                do {
//                    let jsonObject: AnyObject = try NSJSONSerialization.JSONObjectWithData(jsonData, options: [])
//                    
//                    print(jsonObject)
//                    
//                } catch let error {
//                    print("Error creating JSON Object: \(error)")
//                }
//            }
//            else if let requestError = error {
//                print("Error fetching recent photos: \(requestError)")
//            }
//            else {
//                print("Unexpected error with the request")
//            }
        }
        task.resume()
    }
    
    func processRecentRecipesRequest(data data: NSData?, error: NSError?) -> RecipeResult {
        guard let jsonData = data else {
            return .Failure(error!)
        }
        
        return DeploydAPI.recipesFromJSONData(jsonData)
    }
}