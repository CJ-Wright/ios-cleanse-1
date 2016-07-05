//
//  Meal.swift
//  Cleanse App
//
//  Created by Erik Karlsson on 6/26/16.
//  Copyright © 2016 Nano Nimbus. All rights reserved.
//

import UIKit



class Meal {
    var mealName: String
    var mealTime: String
    var mealImageUrl: NSURL?
    var mealImage: UIImage?
    var recipe: Recipe?
    
    init(){
        self.mealName = ""
        self.mealTime = ""
        self.mealImageUrl = nil
        self.recipe = Recipe()
    }
    
    init(mealName: String, mealTime: String, imageUrl: NSURL, recipe: Recipe){
        self.mealTime = mealTime
        self.mealName = mealName
        self.mealImageUrl = imageUrl
        self.recipe = recipe
    }
}