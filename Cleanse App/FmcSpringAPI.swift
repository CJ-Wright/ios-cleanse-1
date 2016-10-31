//
//  FmcSpringAPI.swift
//  Cleanse App
//
//  Created by Erik Karlsson on 9/5/16.
//  Copyright © 2016 Nano Nimbus. All rights reserved.
//

import Foundation

struct FmcSpringAPI {
    fileprivate static let baseURLString = "http://52.52.65.150:8080"
    
    // This function will return the url endpoint of the API server which is used for storing the Recipes and the Meal Plans
    fileprivate static func fmcSpringURL(method: Method, parameters: [String:String]?) -> URL {
        
        // Base component for the NSURL
        let components = URLComponents(string: baseURLString)!
        
        // Array of NSURLQuery Items to be sent along with the requests
        var queryItems = [URLQueryItem]()
        
        // This may not be needed to make rest calls for our application at the moment.
        let baseParams = [
            "format": "json"
        ]
        /* Once the API key has been established then the key:value pair "api_key" : APIKey can be added to the baseParams array */
        
        for (key, value) in baseParams {
            let item = URLQueryItem(name: key, value: value)
            queryItems.append(item)
        }
        
        // This will append any additional items given for when requesting the URL for the deployd server
        if let additionalParams = parameters {
            for(key, value) in additionalParams {
                let item = URLQueryItem(name: key, value: value)
                queryItems.append(item)
            }
        }
        return components.url!
    }
    
    // MARK: - URL GET API Methods
    
    static func recipeURL() -> URL {
        
        // Base URL with the recipes API request call appended to the end of it
        let components = URLComponents(string: baseURLString + "/recipe")!
        var queryItems = [URLQueryItem]()
        
        // Base parameters
        let baseParams = [
            "format": "json"
        ]
        /* Once the API key has been established then the key:value pair "api_key" : APIKey can be added to the baseParams array */
        
        // Append the base parameters to the NSQueryItems array
        for (key, value) in baseParams {
            let item = URLQueryItem(name: key, value: value)
            queryItems.append(item)
        }
        
        return components.url!
    }

    static func recipeSetURL() -> URL {
        
        // Base URL with the recipes API request call appended to the end of it
        let components = URLComponents(string: baseURLString + "/recipe/set")!
        var queryItems = [URLQueryItem]()
        
        // Base parameters
        let baseParams = [
            "format": "json"
        ]
        /* Once the API key has been established then the key:value pair "api_key" : APIKey can be added to the baseParams array */
        
        // Append the base parameters to the NSQueryItems array
        for (key, value) in baseParams {
            let item = URLQueryItem(name: key, value: value)
            queryItems.append(item)
        }
        
        return components.url!
    }
    
    // MARK: - JSON Methods
    // MARK: Recipes From JSON Methods
    static func recipesFromJSONData(_ data: Data) -> RecipeResult {
        do {
            // Attempt to convert the json object into an AnyObject
            //let jsonObject:AnyObject = try JSONSerialization.jsonObject(with: data, options: [])
            let jsonObject:Any = try JSONSerialization.jsonObject(with: data, options: [])
            
            // Create an array of recipes to store the converted JSON Objects
            var finalRecipes = [Recipe]()
            
            for recipeJson in jsonObject as! [Dictionary<String, AnyObject>] {
                
                if let recipe = recipeFromJSONObject(recipeJson){
                    finalRecipes.append(recipe)
                }
            }
            
            if finalRecipes.count == 0 && (jsonObject as AnyObject).count > 0 {
                // We weren't able to parse any of the photso
                // Maybe the JSON format for photos has changed
                print("Failed to get final recipes")
                return .failure(DeploydError.invalidJSONData)
            }
            
            return .success(finalRecipes)
        } catch let error {
            return .failure(error)
        }
    }
    
    // This will take a given JSON Object and constructs a recipe
    static func recipeFromJSONObject(_ json:[String : AnyObject]) -> Recipe? {
        
        guard let recipeID = json["id"] as? String,
            let name = json["name"] as? String,
            let ingredients = json["ingredients"] as? NSMutableArray,
            let serves  = json["serves"] as? String,
            let instructions = json["instructions"] as? String,
            let imgUrlString = json["imgUrl"] as? String
            else {
                print("Failed to parse json")
                return nil
        }
        let imgURL = URL(fileURLWithPath: imgUrlString)
        return Recipe(name: name, instructions: instructions, ingredients: ingredients, recipeID: recipeID, serves: serves, imageURL: imgURL)
    }
}
