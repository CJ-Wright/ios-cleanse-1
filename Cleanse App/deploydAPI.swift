//
//  deploydAPI.swift
//  Cleanse App
//
//  Created by Erik Karlsson on 6/26/16.
//  Copyright © 2016 Nano Nimbus. All rights reserved.
//

import Foundation

enum Method: String {
    case Recipes = "recipes"
}

enum RecipeResult {
    case Success([Recipe])
    case Failure(ErrorType)
}

enum MealPlanResult {
    case Success([MealPlan])
    case Failure(ErrorType)
}

enum DeploydError: ErrorType {
    case InvalidJSONData
}
struct DeploydAPI {
    // The base url of the server to make the requests from
    // "http://ec2-54-215-241-191.us-west-1.compute.amazonaws.com:3000" <- This is my current aws server
    private static let baseURLString = "http://ec2-52-90-78-109.compute-1.amazonaws.com:2403" // <- This is Anthony's server
    
    
    // Empty APIKey for the moment being
    private static let APIKey = ""
    
    
    // This function will return the url endpoint of the API server which is used for storing the Recipes and the Meal Plans
    private static func deploydURL(method method: Method, parameters: [String:String]?) -> NSURL {
        
        // Base component for the NSURL
        let components = NSURLComponents(string: baseURLString)!
        
        // Array of NSURLQuery Items to be sent along with the requests
        var queryItems = [NSURLQueryItem]()
        
        // This may not be needed to make rest calls for our application at the moment.
        let baseParams = [
            "format": "json"
        ]
        /* Once the API key has been established then the key:value pair "api_key" : APIKey can be added to the baseParams array */
        
        for (key, value) in baseParams {
            let item = NSURLQueryItem(name: key, value: value)
            queryItems.append(item)
        }
        
        // This will append any additional items given for when requesting the URL for the deployd server
        if let additionalParams = parameters {
            for(key, value) in additionalParams {
                let item = NSURLQueryItem(name: key, value: value)
                queryItems.append(item)
            }
        }
        return components.URL!
    }
    
    // MARK: - URL GET API Methods
    
    static func recipesURL() -> NSURL {
        
        // Base URL with the recipes API request call appended to the end of it
        let components = NSURLComponents(string: baseURLString + "/recipes")!
        var queryItems = [NSURLQueryItem]()
        
        // Base parameters
        let baseParams = [
            "format": "json"
        ]
        /* Once the API key has been established then the key:value pair "api_key" : APIKey can be added to the baseParams array */
        
        // Append the base parameters to the NSQueryItems array
        for (key, value) in baseParams {
            let item = NSURLQueryItem(name: key, value: value)
            queryItems.append(item)
        }
        
        return components.URL!
    }
    
    
    static func mealPlansURL() -> NSURL {
        
        // Base URL with the recipes API request call appended to the end of it
        let components = NSURLComponents(string: baseURLString + "/meal-plans")!
        var queryItems = [NSURLQueryItem]()
        
        // Base parameters
        let baseParams = [
            "format": "json"
        ]
        /* Once the API key has been established then the key:value pair "api_key" : APIKey can be added to the baseParams array */
        
        // Append the base parameters to the NSQueryItems array
        for (key, value) in baseParams {
            let item = NSURLQueryItem(name: key, value: value)
            queryItems.append(item)
        }
        
        return components.URL!
    }
    
    // MARK: - JSON Methods
    static func recipesFromJSONData(data: NSData) -> RecipeResult {
        do {
            // Attempt to convert the json object into an AnyObject
            let jsonObject:AnyObject = try NSJSONSerialization.JSONObjectWithData(data, options: [])
            
            // Create an array of recipes to store the converted JSON Objects
            var finalRecipes = [Recipe]()
            
            for recipeJson in jsonObject as! [Dictionary<String, AnyObject>] {

//                print("==========================================")
                if let recipe = recipeFromJSONObject(recipeJson){
                    finalRecipes.append(recipe)
                }
            }
 
            if finalRecipes.count == 0 && jsonObject.count > 0 {
                // We weren't able to parse any of the photso
                // Maybe the JSON format for photos has changed
                print("Failed to get final recipes")
                return .Failure(DeploydError.InvalidJSONData)
            }
 
            return .Success(finalRecipes)
        } catch let error {
            return .Failure(error)
        }
    }
    
    // This will take a given JSON Object and constructs a recipe
    static func recipeFromJSONObject(json:[String : AnyObject]) -> Recipe? {
        
        guard let recipeID = json["id"] as? String,
            name = json["recipeName"] as? String,
            ingredients = json["ingredients"] as? [String],
            serves  = json["serves"] as? String,
            instructions = json["instructions"] as? String else {
                print("Failed to parse json")
                return nil
        }
        
        // Debugging statement to see the json that is returned after making the request
//        print("Recipe ID : \(recipeID) \n - Name : \(name) \n - Ingredients [\(ingredients) \n - Serves : \(serves) \n - Instructions: \(instructions)")
        
        return Recipe(name: name, instructions: instructions, ingredients: ingredients, recipeID: recipeID, serves: serves)
    }
    
    // -----
    static func mealPlansFromJSONData(data: NSData) -> MealPlanResult {
        do {
            // Attempt to convert the json object into an AnyObject
            let jsonObject:AnyObject = try NSJSONSerialization.JSONObjectWithData(data, options: [])
            
            // Create an array of recipes to store the converted JSON Objects
            var finalMealPlans = [MealPlan]()
            
            for mealPlanJson in jsonObject as! [Dictionary<String, AnyObject>] {
                
                if let mealPlan = mealPlanFromJSONObject(mealPlanJson){
                    finalMealPlans.append(mealPlan)
                }
            }
            
            if finalMealPlans.count == 0 && jsonObject.count > 0 {
                // We weren't able to parse any of the photso
                // Maybe the JSON format for photos has changed
                print("Failed to get final meal plans")
                return .Failure(DeploydError.InvalidJSONData)
            }
            
            return .Success(finalMealPlans)
        } catch let error {
            return .Failure(error)
        }
    }
    
    // This will take a given JSON Object and constructs a recipe
    static func mealPlanFromJSONObject(json:[String : AnyObject]) -> MealPlan? {
        
        guard let recipeID = json["id"] as? String,
            name = json["recipeName"] as? String,
            ingredients = json["ingredients"] as? [String],
            serves  = json["serves"] as? String,
            instructions = json["instructions"] as? String else {
                print("Failed to parse json")
                return nil
        }
        
        // Debugging statement to see the json that is returned after making the request
        //        print("Recipe ID : \(recipeID) \n - Name : \(name) \n - Ingredients [\(ingredients) \n - Serves : \(serves) \n - Instructions: \(instructions)")
        
        return MealPlan()
    }
    
    
}