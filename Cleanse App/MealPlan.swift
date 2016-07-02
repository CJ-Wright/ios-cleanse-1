//
//  MealPlan.swift
//  Cleanse App
//
//  Created by Erik Karlsson on 6/25/16.
//  Copyright © 2016 Nano Nimbus. All rights reserved.
//

import UIKit


class MealPlan {
    
    var mealPlanName: String
    var numberOfDays: Int
    var days: NSMutableArray
    var mealPlanID: String
    
    
    init(){
        self.mealPlanName = "Sample Meal Plan"
        self.numberOfDays = 0
        self.days = NSMutableArray()
        self.mealPlanID = ""
    }
    
    init(name: String, numberOfDays: Int, days: NSMutableArray, mealPlanID: String){
        self.mealPlanName = name
        self.numberOfDays = numberOfDays
        self.days = days
        self.mealPlanID = mealPlanID
    }
    
    func addDailyPlan(inout meals: [Meal], dayNum: Int, atAGlance: [String])
    {
        let dailyPlan = DailyPlan(dayNum: dayNum, meals: &meals, atAGlance: atAGlance)
        self.days.addObject(dailyPlan)
    }
}