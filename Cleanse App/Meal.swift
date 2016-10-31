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
        
        guard let mealTime = decoder.decodeObject(forKey: "mealTime") as? String,
            let recipe = decoder.decodeObject(forKey: "recipe") as? Recipe
            else {
                print("Failed to init Meal from archiver")
                return nil
        }
        
        self.init(
            mealTime: mealTime,
            recipe: recipe
            
        )
    }
    
    func encode(with coder: NSCoder) {
        
        coder.encode(self.mealTime, forKey: "mealTime")
        coder.encode(self.recipe, forKey: "recipe")
    }
    
    func changeRecipe(_ recipe:Recipe) {
        self.recipe = recipe
    }
}
