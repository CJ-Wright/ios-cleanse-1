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
    var startingDate: NSDate
    var finishedSave: Bool?
    var saveResult: Bool?
    
    
    override init(){
        self.mealPlanName = "Sample Meal Plan"
        self.numberOfDays = 0
        self.days = NSMutableArray()
        self.mealPlanID = ""
        self.startingDate = NSDate()
    }
    
    init(name: String, numberOfDays: Int, days: NSMutableArray, mealPlanID: String, startingDate: NSDate){
        self.mealPlanName = name
        self.numberOfDays = numberOfDays
        self.days = days
        self.mealPlanID = mealPlanID
        self.startingDate = startingDate
    }
    
    init(name: String, numberOfDays: Int, days: NSMutableArray, mealPlanID: String){
        self.mealPlanName = name
        self.numberOfDays = numberOfDays
        self.days = days
        self.mealPlanID = mealPlanID
        self.startingDate = NSDate()
    }
    
    
    // This is the path to where the information for the meal plans are stored.
    let mealPlanArchiveURL: NSURL = {
        let documentsDirectories =
            NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.URLByAppendingPathComponent("mealplans.archive")!
    }()
    
    // MARK: NSCoding
    required convenience init?(coder decoder: NSCoder){
        guard let mealPlanName = decoder.decodeObjectForKey("mealPlanName") as? String,
            let days = decoder.decodeObjectForKey("days") as? NSMutableArray,
            let mealPlanID = decoder.decodeObjectForKey("mealPlanID") as? String,
            let startingDate = decoder.decodeObjectForKey("startingDate") as? NSDate
            else {
//                print("Failed to init [ Meal Plan ] from archiver")
                return nil
        }
//        print("[Meal Plan] Success!")
        
        self.init(
            name:mealPlanName,
            numberOfDays: decoder.decodeIntegerForKey("numberOfDays"),
            days:days,
            mealPlanID: mealPlanID,
            startingDate: startingDate
        )
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
//        print("Meal \(mealPlanName) - \(numberOfDays) - \(mealPlanID)")
        aCoder.encodeObject(self.mealPlanName, forKey: "mealPlanName")
        aCoder.encodeInt(Int32(self.numberOfDays), forKey: "numberOfDays")
        aCoder.encodeObject(self.days, forKey: "days")
        aCoder.encodeObject(self.mealPlanID, forKey: "mealPlanID")
        aCoder.encodeObject(self.startingDate, forKey: "startingDate")
    }
    
    func changeMealRecipe(recipe: Recipe, dailyPlanIndex: Int, mealIndex:Int){
//        print("Changing Day \(dailyPlanIndex) and Meal Index \(mealIndex)")
        ((self.days[dailyPlanIndex] as! DailyPlan).meals[mealIndex] as! Meal).changeRecipe(recipe)
    }
    
    
    func saveChanges() -> Bool {
//        print("Saving meal plan to \(mealPlanArchiveURL.path!)")
        self.finishedSave = false
        self.saveResult = NSKeyedArchiver.archiveRootObject(self, toFile: mealPlanArchiveURL.path!)
//        print("Done saving meal plan")
        self.finishedSave = false
        return self.saveResult!
    }
    
}
