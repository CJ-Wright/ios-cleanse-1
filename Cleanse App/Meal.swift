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
    
    init(){
        self.mealName = ""
        self.mealTime = ""
        self.mealImageUrl = nil
    }
    
    init(mealName: String, mealTime: String, imageUrl: NSURL){
        self.mealTime = mealTime
        self.mealName = mealName
        self.mealImageUrl = imageUrl
    }
}