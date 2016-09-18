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
        guard let mealPlanName = decoder.decodeObject(forKey: "mealPlanName") as? String,
            let days = decoder.decodeObject(forKey: "days") as? NSMutableArray,
//            let numberOfDays = decoder.decodeObjectForKey("numberOfDays") as? Int,
            let mealPlanID = decoder.decodeObject(forKey: "mealPlanID") as? String
        else {
            print("Failed to init [ Meal Plan ] from archiver")
            return nil
        }
        print("[Meal Plan] Success!")
        
        self.init(
            name:mealPlanName,
            numberOfDays: decoder.decodeInteger(forKey: "numberOfDays"),
            days:days,
            mealPlanID: mealPlanID
        )
    }
    
    func encode(with aCoder: NSCoder) {
        print("Meal \(mealPlanName) - \(numberOfDays) - \(mealPlanID)")
        aCoder.encode(self.mealPlanName, forKey: "mealPlanName")
//        aCoder.encodeObject(self.numberOfDays, forKey: "numberOfDays")
        aCoder.encodeCInt(Int32(self.numberOfDays), forKey: "numberOfDays")
        aCoder.encode(self.days, forKey: "days")
        aCoder.encode(self.mealPlanID, forKey: "mealPlanID")
    }
    
    func changeMealRecipe(_ recipe: Recipe, dailyPlanIndex: Int, mealIndex:Int){
        print("Changing Day \(dailyPlanIndex) and Meal Index \(mealIndex)")
        ((self.days[dailyPlanIndex] as! DailyPlan).meals[mealIndex] as! Meal).changeRecipe(recipe)
    }
}
