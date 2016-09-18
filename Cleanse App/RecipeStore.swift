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
    static var recipeSet = Set<Recipe>()
    
    let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    func fetchRecipes(completion: @escaping (RecipeResult) -> Void) {
        let url = DeploydAPI.recipesURL()
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
        
        return DeploydAPI.recipesFromJSONData(jsonData)
    }
    
    func initRecipes(){
        if !RecipeStore.recipesReceived {
            // Attempt to fetch the recipes
            fetchRecipes() {
                (recipeResult) -> Void in
                
                switch recipeResult {
                case let .success(recipes):
                     print("Successfully found \(recipes)")
                    RecipeStore.recipesReceived = true
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
}
