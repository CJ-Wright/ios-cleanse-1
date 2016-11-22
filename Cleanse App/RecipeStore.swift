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
    static var recipeSet = Set<Recipe>()
    static var availableSets = Dictionary<String, [Recipe]>()
    
    
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
    
    func processRecentRecipesRequest(data: Data?, error: NSError?) -> RecipeResult {
        guard let jsonData = data else {
            return .failure(error!)
        }
        
        return DeploydAPI.recipesFromRecipeSetJSONData(jsonData)
    }
    
    func downloadRecipeSet(productKey: String){
        if !RecipeStore.recipesReceived {
            // Attempt to fetch the recipes
            fetchRecipes(productKey: productKey) {
                (recipeResult) -> Void in
                switch recipeResult {
                case let .success(recipes):
                    
                    RecipeStore.recipesReceived = true
                    var cntr = 0
                    for recipe in recipes {
                        print("Counter \(cntr)")
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
                    RecipeStore.availableSets[productKey] = recipes
                    print(RecipeStore.availableSets)
                case let .failure(error):
                    print("Error fetching recipes: \(error)")
                    RecipeStore.recipesReceived = false
                }
            }
        }
    }
    
    func addRecipeToStore(_ recipe:Recipe){
        RecipeStore.recipeSet.insert(recipe)
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
//            print("Photo URL is \(photoURL)")
            
            let request = URLRequest(url:photoURL as URL)
            //print("Image starting download \(counter)...")
//            print("Starting downloaded for recipe \(recipe.name)")
            
            let task = session.dataTask(with: request, completionHandler: {
                (data, response, error) -> Void in
                if let imageData = data as Data? {
                    recipe.image = UIImage(data: imageData)!
//                    print("Downloaded image for \(recipe.name)")
                }
                else{
                    print("Error \(error)")
                }
            })
            
            task.resume()
        }
    }

}

