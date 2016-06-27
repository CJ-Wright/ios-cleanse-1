//
//  RecipeStore.swift
//  Cleanse App
//
//  Created by Erik Karlsson on 6/2/16.
//  Copyright © 2016 Nano Nimbus. All rights reserved.
//

import UIKit

class RecipeStore: NSObject {
    
    static let sharedInstance = RecipeStore()
    static var recipesReceived = false
    
    let session: NSURLSession = {
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        return NSURLSession(configuration: config)
    }()
    
    func fetchRecipes(completion completion: (RecipeResult) -> Void) {
        let url = DeploydAPI.recipesURL()
        print(url)
        let request = NSURLRequest(URL:url)
        print(request)
        let task = session.dataTaskWithRequest(request) {
            (data, response, error) -> Void in
            
            
                let result = self.processRecentRecipesRequest(data: data, error: error)
            completion(result)
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