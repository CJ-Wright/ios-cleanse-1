//
//  DailyPlan.swift
//  Cleanse App
//
//  Created by Erik Karlsson on 6/26/16.
//  Copyright © 2016 Nano Nimbus. All rights reserved.
//

import Foundation


class DailyPlan: NSObject, NSCoding {
    var dayNumber: Int
    var meals:NSMutableArray
    var atAGlance: NSMutableArray
    var atAGlanceInstruction: String
    var tipOfTheDay: String
    var detoxFacts: String
    var dailyInspiration: String
    var amountDrank: Int
    var minShakesForDay: Int?
    
    override init(){
        self.atAGlanceInstruction = ""
        self.tipOfTheDay = ""
        self.detoxFacts = ""
        self.dailyInspiration = ""
        self.dayNumber = 0
        self.meals = NSMutableArray()
        self.atAGlance = NSMutableArray()
        self.amountDrank = 0
        self.minShakesForDay = 0
    }
    
    init(dayNum: Int, meals: NSMutableArray, atAGlance: NSMutableArray, amountDrank: Int, atAGlanceInstruction:String, detoxFacts:String, tipOfTheDay:String, dailyInspiration:String){
        self.dayNumber = dayNum
        self.meals = NSMutableArray()
        self.atAGlance = NSMutableArray()
        self.amountDrank = amountDrank
        self.atAGlanceInstruction = atAGlanceInstruction
        self.tipOfTheDay = tipOfTheDay
        self.detoxFacts = detoxFacts
        self.dailyInspiration = dailyInspiration
        for meal in meals {
            self.meals.add(meal)
        }
        for aString in atAGlance {
            self.atAGlance.add(aString)
            // Determine nShakes
            if (aString as! String).contains("Shakes") {
                self.minShakesForDay = Int(String((aString as! String)[(aString as! String).startIndex]))!
            }
        }
    }
    
    // MARK: NSCoding
    
    required convenience init?(coder decoder: NSCoder) {
        guard let mealsArray = decoder.decodeObject(forKey: "meals") as? NSMutableArray else {
            print("Failed to Meals Array Daily Plan from archiver")
            return nil
        }
        guard let atAGlance = decoder.decodeObject(forKey: "atAGlance") as? NSMutableArray
            else {
                print("Failed to At A Glance Daily Plan from archiver")
                return nil
        }
        
        /*
        guard let amountDrank = decoder.decodeObject(forKey: "amountDrank") as? Int
            else {
                print("Failed to decode amount drank in daily plan")
                return nil
        }*/
        
        guard let atAGlanceInstruction = decoder.decodeObject(forKey: "atAGlanceInstruction") as? String,
            let detoxFacts = decoder.decodeObject(forKey: "detoxFacts") as? String,
            let tipOfTheDay = decoder.decodeObject(forKey: "tipOfTheDay") as? String,
            let dailyInspiration = decoder.decodeObject(forKey: "dailyInspiration") as? String else {
                print("Failed to decode a string in a daily plan")
                return nil
        }
        
        
        
        self.init(
            dayNum: decoder.decodeInteger(forKey: "dayNumber"),
            meals: mealsArray,
            atAGlance: atAGlance,
            amountDrank: decoder.decodeInteger(forKey: "amountDrank"),
            atAGlanceInstruction: atAGlanceInstruction,
            detoxFacts: detoxFacts,
            tipOfTheDay: tipOfTheDay,
            dailyInspiration: dailyInspiration
        )
    }
    
    func encode(with aCoder: NSCoder) {
        //        aCoder.encodeObject(self.dayNumber, forKey: "dayNumber")
        aCoder.encode(self.dayNumber, forKey: "dayNumber")
        aCoder.encode(self.meals, forKey: "meals")
        aCoder.encode(self.atAGlance, forKey: "atAGlance")
        aCoder.encode(Int32(self.amountDrank), forKey: "amountDrank")
        aCoder.encode(self.atAGlanceInstruction, forKey: "atAGlanceInstruction")
        aCoder.encode(self.detoxFacts, forKey:"detoxFacts")
        aCoder.encode(self.tipOfTheDay, forKey:"tipOfTheDay")
        aCoder.encode(self.dailyInspiration, forKey: "dailyInspiration")
        
    }
    
    func updateAmountDrank(_ amountDrank: Int){
        self.amountDrank = amountDrank
    }
}
