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
    var startingDate: Date
    var finishedSave: Bool?
    var saveResult: Bool?
     
    
    override init(){
        self.mealPlanName = "Sample Meal Plan"
        self.numberOfDays = 0
        self.days = NSMutableArray()
        self.mealPlanID = ""
        self.startingDate = Date()
    }
    
    init(name: String, numberOfDays: Int, days: NSMutableArray, mealPlanID: String, startingDate: Date){
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
        
        let date: Date = Date()
        let cal: Calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        
//        let newDate: NSDate = cal.dateBySettingHour(0, minute: 0, second: 0, ofDate: date, options: NSCalendarOptions())!
//        self.startingDate = newDate
        self.startingDate = cal.startOfDay(for: date)
    }
    
    
    // This is the path to where the information for the meal plans are stored.
    let mealPlanArchiveURL: URL = {
        let documentsDirectories =
            FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("mealplans.archive")
    }()
    
    // MARK: NSCoding
    required convenience init?(coder decoder: NSCoder){
        guard let mealPlanName = decoder.decodeObject(forKey: "mealPlanName") as? String,
            let days = decoder.decodeObject(forKey: "days") as? NSMutableArray,
            let mealPlanID = decoder.decodeObject(forKey: "mealPlanID") as? String,
            let startingDate = decoder.decodeObject(forKey: "startingDate") as? Date
            else {
//                print("Failed to init [ Meal Plan ] from archiver")
                return nil
        }
//        print("[Meal Plan] Success!")
        
        self.init(
            name:mealPlanName,
            numberOfDays: decoder.decodeInteger(forKey: "numberOfDays"),
            days:days,
            mealPlanID: mealPlanID,
            startingDate: startingDate
        )
    }
    
    func encode(with aCoder: NSCoder) {
//        print("Meal \(mealPlanName) - \(numberOfDays) - \(mealPlanID)")
        aCoder.encode(self.mealPlanName, forKey: "mealPlanName")
        aCoder.encodeCInt(Int32(self.numberOfDays), forKey: "numberOfDays")
        aCoder.encode(self.days, forKey: "days")
        aCoder.encode(self.mealPlanID, forKey: "mealPlanID")
        aCoder.encode(self.startingDate, forKey: "startingDate")
    }
    
    func changeMealRecipe(_ recipe: Recipe, dailyPlanIndex: Int, mealIndex:Int){
//        print("Changing Day \(dailyPlanIndex) and Meal Index \(mealIndex)")
        ((self.days[dailyPlanIndex] as! DailyPlan).meals[mealIndex] as! Meal).changeRecipe(recipe)
    }
    
    
    func saveChanges() -> Bool {
//        print("Saving meal plan to \(mealPlanArchiveURL.path!)")
        self.finishedSave = false
        self.saveResult = NSKeyedArchiver.archiveRootObject(self, toFile: mealPlanArchiveURL.path)
//        print("Done saving meal plan")
        self.finishedSave = false
        return self.saveResult!
    }
    
    func resetStartDay() {
        self.startingDate = Date()
    }
}
