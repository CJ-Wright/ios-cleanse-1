//
//  Meal.swift
//  Cleanse App
//
//  Created by Erik Karlsson on 6/26/16.
//  Copyright © 2016 Nano Nimbus. All rights reserved.
//

import UIKit



class Meal: NSObject, NSCoding {
    var mealTime: String
    var mealImage: UIImage?
    var recipe: Recipe?
    
    override init(){
        self.mealTime = ""
        self.recipe = Recipe()
    }
    
    init(mealTime: String, recipe: Recipe ){
        self.mealTime = mealTime
        self.recipe = recipe
    }
    
    // MARK: NSCoding
    
    required convenience init?(coder decoder: NSCoder) {
        
        guard let mealTime = decoder.decodeObjectForKey("mealTime") as? String,
            let recipe = decoder.decodeObjectForKey("recipe") as? Recipe
            else {
                print("Failed to init Meal from archiver")
                return nil
        }
        
        self.init(
            mealTime: mealTime,
            recipe: recipe
            
        )
    }
    
    func encodeWithCoder(coder: NSCoder) {
        
        coder.encodeObject(self.mealTime, forKey: "mealTime")
        coder.encodeObject(self.recipe, forKey: "recipe")
    }
    
    func changeRecipe(recipe:Recipe) {
        self.recipe = recipe
    }
}
