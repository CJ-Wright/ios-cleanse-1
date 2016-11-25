//
//  RecipeStore.swift
//  Cleanse App
//
//  Created by Erik Karlsson on 6/2/16.
//  Copyright © 2016 Nano Nimbus. All rights reserved.
//

import UIKit
import StoreKit

class RecipeStore: NSObject {
    
    static let sharedInstance = RecipeStore()
    static var recipesReceived = false
    static var availableRecipeSets = Dictionary<String,[Recipe]>()
    static var purchasedRecipeSetIDs = Set<String>()
    static var unpurchasedAvailableSets = Dictionary<String, [Recipe]>()
    static var generalRecipesAdded = false
    var numRecipes: Int
    
    override init() {
        self.numRecipes = 0
    }
    
    
    // This is the path to where the information for the meal plans are stored.
    let recipeSetArchiveURL: URL = {
        let documentsDirectories =
            FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("mealplans.archive")
    }()
    
    let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    // Performs an asynchronous request for recipes from the server. 
    func fetchRecipes(productKey:String, completion: @escaping (RecipeResult) -> Void) {
        let url = DeploydAPI.recipeSetURL(productKey: productKey)
        print("Recipe Set URL \(url)")
        let request = URLRequest(url:url as URL)
        let task = session.dataTask(with: request, completionHandler: {
            (data, response, error) -> Void in
            let result = self.processRecentRecipesRequest(data: data, error: error as NSError?)
            completion(result)
        })
        task.resume()
    }
    
    // Processes the Recipes
    func processRecentRecipesRequest(data: Data?, error: NSError?) -> RecipeResult {
        guard let jsonData = data else {
            return .failure(error!)
        }
        return DeploydAPI.recipesFromRecipeSetJSONData(jsonData)
    }
    
    // Given a product key this will query the API Server and receive JSON object containing the recipes and img urls.
    // It will download and save the JSON and images inside the RecipeStore object.
    func downloadRecipeSet(productKey: String){
        if !RecipeStore.recipesReceived {
            // Attempt to fetch the recipes
            fetchRecipes(productKey: productKey) {
                (recipeResult) -> Void in
                switch recipeResult {
                case let .success(recipes):
                    
                    RecipeStore.recipesReceived = true
                    for recipe in recipes {
                        self.fetchImageForPhoto(recipe, completion: {
                            (ImageResult) -> Void in
                            switch ImageResult {
                            case .success(_):
                                print("Downloaded the image")
                            case .failure(_):
                                print("Error downloading the image")
                            }
                        })
                    }
                    RecipeStore.unpurchasedAvailableSets[productKey] = recipes
                    let userDefaults : UserDefaults = UserDefaults.standard
                    if userDefaults.bool(forKey: productKey){
                        RecipeStore.purchasedRecipeSetIDs.insert(productKey)
                    }
                case let .failure(error):
                    print("Error fetching recipes: \(error)")
                    RecipeStore.recipesReceived = false
                }
            }
        }
    }
    
    static func addRecipeToStore(setName:String, recipe:Recipe){
        if RecipeStore.availableRecipeSets[setName] == nil {
            RecipeStore.availableRecipeSets[setName] = [Recipe]()
        }
        RecipeStore.availableRecipeSets[setName]!.append(recipe)
    }
    
    static func updateRecipeSet(){
        let userDefaults : UserDefaults = UserDefaults.standard
        for productKey in RecipeSetProducts.RECIPE_SETS {
            if userDefaults.bool(forKey: productKey ){
                RecipeStore.purchasedRecipeSetIDs.insert(productKey)
            }
        }
        if RecipeStore.availableRecipeSets.isEmpty || !RecipeStore.generalRecipesAdded {
            print("Is empty... adding the original")
            RecipeStore.availableRecipeSets["Original"] = [Recipe]()
            for day in MealPlanStore.currentMealPlan.days {
                if let dailyPlan = day as? DailyPlan {
                    for dailyMeal in dailyPlan.meals {
                        if let meal = dailyMeal as? Meal {
                            if let recipe = meal.recipe {
                                recipe.name = meal.recipe!.name
                                recipe.image = meal.recipe!.image
                                if !RecipeStore.availableRecipeSets["Original"]!.contains(recipe) {
                                    RecipeStore.addRecipeToStore(setName: "Original", recipe: recipe)
                                }
                            }
                        }
                    }
                }
            }
            RecipeStore.generalRecipesAdded = true
            print("Done adding the original")
        }

        for recipeSetID in RecipeStore.purchasedRecipeSetIDs {
            if userDefaults.bool(forKey: recipeSetID ){
                for recipe in RecipeStore.unpurchasedAvailableSets[recipeSetID]! {
                    RecipeStore.addRecipeToStore(setName: recipeSetID, recipe: recipe)
                }
            }
        }
    }
    
    // MARK: - Persistence
    // Method will check if the given user has a meal plan, and if they do, try to load the file.
    func loadRecipeSetsFromArchive() -> Bool {
        
        if let archivedItems = NSKeyedUnarchiver.unarchiveObject(withFile: recipeSetArchiveURL.path) as? MealPlan {
            //            RecipeStore.currentMealPlan = archivedItems
            //            RecipeStore.plansReceived = true
            //print("Successfully unarchived plans")
        } else {
            //            MealPlanStore.plansReceived = false
            //print("Failed to unarchive plans")
        }
        
        return false
    }
    
    func saveChanges() -> Bool {
        print("Saving meal plan to \(recipeSetArchiveURL.path)")
        let result = NSKeyedArchiver.archiveRootObject(MealPlanStore.currentMealPlan, toFile: recipeSetArchiveURL.path)
        print("Done saving")
        return result
    }
    
    /*
     Method for retrieving the photo from URL in the given Meal
     */
    func fetchImageForPhoto(_ recipe: Recipe, completion: (ImageResult) -> Void){
        
        if let photoURL = recipe.imageURL {
            let request = URLRequest(url:photoURL as URL)
            
            let task = session.dataTask(with: request, completionHandler: {
                (data, response, error) -> Void in
                if let imageData = data as Data? {
                    recipe.image = UIImage(data: imageData)!
                }
                else{
                    print("Error \(error)")
                }
            })
            
            task.resume()
        }
    }
    
}

