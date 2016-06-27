//
//  Meal.swift
//  Cleanse App
//
//  Created by Erik Karlsson on 6/26/16.
//  Copyright © 2016 Nano Nimbus. All rights reserved.
//

import Foundation

class Meal {
    var mealName: String
    var mealTime: String
    
    init(mealName: String, mealTime: String){
        self.mealTime = mealTime
        self.mealName = mealName
    }
}