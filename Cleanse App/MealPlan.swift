//
//  MealPlan.swift
//  Cleanse App
//
//  Created by Erik Karlsson on 6/25/16.
//  Copyright © 2016 Nano Nimbus. All rights reserved.
//

import UIKit


class MealPlan: NSObject, NSCoding {
    
    var mealPlanName: String
    var numberOfDays: Int
    var days: NSMutableArray
    var mealPlanID: String
    
    
    override init(){
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
    
    /*func addDailyPlan(inout meals: [Meal], dayNum: Int, atAGlance: [String])
    {
        let dailyPlan = DailyPlan(dayNum: dayNum, meals: meals, atAGlance: atAGlance)
        self.days.addObject(dailyPlan)
    }*/
    
    // MARK: NSCoding
    required convenience init?(coder decoder: NSCoder){
        guard let mealPlanName = decoder.decodeObjectForKey("mealPlanName") as? String,
            let days = decoder.decodeObjectForKey("days") as? NSMutableArray,
            let numberOfDays = decoder.decodeObjectForKey("numberOfDays") as? Int,
            let mealPlanID = decoder.decodeObjectForKey("mealPlanID") as? String
        else {
            return nil
        }
        
        self.init(
            name:mealPlanName,
            numberOfDays: numberOfDays,
            days:days,
            mealPlanID: mealPlanID
        )
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.mealPlanName, forKey: "mealPlanName")
        aCoder.encodeObject(self.numberOfDays, forKey: "numberOfDays")
        aCoder.encodeObject(self.days, forKey: "days")
        aCoder.encodeObject(self.mealPlanID, forKey: "mealPlanID")
    }
}