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
    case success([Recipe])
    case failure(Error)
}

enum MealPlanResult {
    //    case Success([MealPlan])
    case success(NSMutableArray)
    case failure(Error)
}

enum DeploydError: Error {
    case invalidJSONData
}
struct DeploydAPI {
    // The base url of the server to make the requests from
    //    private static let baseURLString = "http://52.52.65.150:3000" // <- This is my current aws server
    //    private static let baseURLString = "http://ec2-52-90-78-109.compute-1.amazonaws.com:2403"  // <- This is Anthony's server
    fileprivate static let baseURLString = "http://52.52.65.150:8080"
    
    // Empty APIKey for the moment being
    fileprivate static let APIKey = ""
    
    // This function will return the url endpoint of the API server which is used for storing the Recipes and the Meal Plans
    fileprivate static func deploydURL(method: Method, parameters: [String:String]?) -> URL {
        
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
    
    static func recipesURL() -> URL {
        
        // Base URL with the recipes API request call appended to the end of it
        let components = URLComponents(string: baseURLString + "/recipes")!
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
    
    static func mealPlansURL() -> URL {
        
        // Base URL with the recipes API request call appended to the end of it
        //        let components = NSURLComponents(string: baseURLString + "/meal-plans")!
        let components = URLComponents(string: baseURLString + "/mealplan")!
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
            let jsonObject:Any = try JSONSerialization.jsonObject(with: data, options: [])
            
            // Create an array of recipes to store the converted JSON Objects
            var finalRecipes = [Recipe]()
            
            for recipeJson in jsonObject as! [Dictionary<String, AnyObject>] {
                
                if let recipe = recipeFromJSONObject(recipeJson){
                    finalRecipes.append(recipe)
                }
            }
            
            if finalRecipes.count == 0 {
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
            let imageURLString = json["imgUrl"] as? String else {
                print("Failed to parse json")
                return nil
        }
        let imageURL = URL(fileURLWithPath: imageURLString)
        return Recipe(name: name, instructions: instructions, ingredients: ingredients, recipeID: recipeID, serves: serves, imageURL: imageURL)
    }
    
    // MARK: Meal Plans From JSON Methods
    static func mealPlansFromJSONData(_ data: Data) -> MealPlanResult {
        do {
            // Attempt to convert the json object into an AnyObject
            let jsonObject:Any = try JSONSerialization.jsonObject(with: data, options: [])
            
            // Create an array of recipes to store the converted JSON Objects
            var finalMealPlans = NSMutableArray()
            
            //            let mealPlanJson = jsonObject as! Dictionary<String, AnyObject>
            let mealPlanJson = jsonObject as! [String:AnyObject]
            
            //            print(mealPlan["MealPlan"])
            if let mealPlan = mealPlanFromJSONObject(mealPlanJson){
                finalMealPlans.add(mealPlan)
            }
            
            if finalMealPlans.count == 0  {
                // We weren't able to parse any of the photso
                // Maybe the JSON format for photos has changed
                print("Failed to get final meal plans")
                return .failure(DeploydError.invalidJSONData)
            }
            
            return .success(finalMealPlans)
        } catch let error {
            return .failure(error)
        }
    }
    
    
    // This will take a given JSON Object and constructs a recipe
    static func mealPlanFromJSONObject(_ mealPlanJson:[String : AnyObject]) -> MealPlan? {
        
        guard let json = mealPlanJson["MealPlan"],
            let name = json["name"] as? String,
            let days = json["dailyPlans"] as? [Dictionary<String, AnyObject>]
            else {
                print("Failed to parse json")
                return nil
        }
        
        //        print(json)
        
        let totalPlans = NSMutableArray(capacity: days.count)
        
        for dailyPlan in days {
            if let plan = dailyPlanFromJSONMealPlan(dailyPlan) {
//                totalPlans[plan.dayNumber - 1] = plan
                totalPlans.add(plan)
            }
        }
        
//        totalPlans = totalPlans.sorted
//        var sortedPlans = sorted(totalPlans) {
//            let
//        }
        let planID = "0"
        let mealPlan = MealPlan(name: name, numberOfDays: totalPlans.count, days: totalPlans, mealPlanID: planID)
        
        return mealPlan
    }
    
    static func dailyPlanFromJSONMealPlan(_ json:[String:AnyObject]) -> DailyPlan? {
        
        var meal: Meal
        let dailyPlan = DailyPlan()
        
        guard let mealsJson = json["meals"] else {
            print("Failed to parse the daily plan json -- Meals")
            return nil
        }
        guard let atAGlance = json["atAGlance"] as? [String] else {
            print("Failed to parse the daily plan json -- atAGlance")
            return nil
        }
        guard let day = json["day"] as? String else {
            print("Failed to parse the daily plan json -- Day")
            return nil
        }
        
        // Parse the daily meal plan into individual meals
        for mealJson in mealsJson as! [Dictionary<String, AnyObject>]{
            meal = Meal()
            
            // Attempt to parse the indiviual meal json into a meal object
            guard let recipe = mealJson["recipe"] as? [String:AnyObject],
                let mealTime = mealJson["time"] as? String else {
                    print("Failed to parse meals in daily plan")
                    return nil
            }
            
            guard let recipeName = recipe["name"] as? String,
                let imgUrl = recipe["imgUrl"] as? String,
                let ingredients = recipe["ingredients"] as? [String],
                let instructions = recipe["instructions"] as? String,
                let serves = recipe["serves"] as? String else {
                    print("Failed to parse recipe in meal json")
                    return nil
            }
            
            
            // Assign the values to the meal object
            //            meal.mealName = mealName
            meal.mealTime = mealTime
            for ingredient in ingredients {
                meal.recipe?.ingredients.add(ingredient)
            }
            meal.recipe?.name = recipeName
            meal.recipe?.instructions = instructions
            meal.recipe?.serves = serves
            
            
            meal.recipe?.imageURL = URL(string:imgUrl)
            dailyPlan.meals.add(meal)
        }
        for aString in atAGlance {
            dailyPlan.atAGlance.add(aString)
        }
        
        dailyPlan.dayNumber = Int(day)!
        
        return dailyPlan
    }
}
