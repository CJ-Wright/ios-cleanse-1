//
//  Meal.swift
//  Cleanse App
//
//  Created by Erik Karlsson on 6/26/16.
//  Copyright © 2016 Nano Nimbus. All rights reserved.
//

import UIKit



class Meal: NSObject, NSCoding {
    var mealName: String
    var mealTime: String
    var mealImageUrl: NSURL?
    var mealImage: UIImage?
    var recipe: Recipe?
    
    override init(){
        self.mealName = ""
        self.mealTime = ""
        self.mealImageUrl = nil
        self.recipe = Recipe()
    }
    
    init(mealName: String, mealTime: String, imageUrl: NSURL, recipe: Recipe ){
        self.mealTime = mealTime
        self.mealName = mealName
        self.mealImageUrl = imageUrl
        self.recipe = recipe
    }
    
    // MARK: NSCoding
    
    required convenience init?(coder decoder: NSCoder) {
        guard let mealName = decoder.decodeObjectForKey("mealName") as? String,
            let mealTime = decoder.decodeObjectForKey("mealTime") as? String,
            let mealImageUrl = decoder.decodeObjectForKey("mealImageUrl") as? NSURL,
            let mealImage = decoder.decodeObjectForKey("mealImage") as? UIImage,
            let recipe = decoder.decodeObjectForKey("recipe") as? Recipe
            else {
                print("Failed to init Meal from archiver")
                return nil
        }
        
        self.init(
            mealName:mealName,
            mealTime: mealTime,
            imageUrl: mealImageUrl,
            recipe: recipe
            
        )
        self.mealImage = mealImage
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.mealName, forKey: "mealName")
        coder.encodeObject(self.mealTime, forKey: "mealTime")
        coder.encodeObject(self.mealImage, forKey: "mealImage")
        coder.encodeObject(self.mealImageUrl, forKey: "mealImageUrl")
        coder.encodeObject(self.recipe, forKey: "recipe")
    }
}