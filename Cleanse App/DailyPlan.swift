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
    
    override init(){
        self.atAGlanceInstruction = ""
        self.tipOfTheDay = ""
        self.detoxFacts = ""
        self.dailyInspiration = ""
        self.dayNumber = 0
        self.meals = NSMutableArray()
        self.atAGlance = NSMutableArray()
        self.amountDrank = 0
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
            self.meals.addObject(meal)
        }
        for aString in atAGlance{
            self.atAGlance.addObject(aString)
        }
    }
    
    // MARK: NSCoding
    
    required convenience init?(coder decoder: NSCoder) {
        guard let mealsArray = decoder.decodeObjectForKey("meals") as? NSMutableArray else {
            print("Failed to Meals Array Daily Plan from archiver")
            return nil
        }
        guard let atAGlance = decoder.decodeObjectForKey("atAGlance") as? NSMutableArray
            else {
                print("Failed to At A Glance Daily Plan from archiver")
                return nil
        }
        
        guard let amountDrank = decoder.decodeObjectForKey("amountDrank") as? Int
            else {
                print("Failed to decode amount drank in daily plan")
                return nil
        }
        
        guard let atAGlanceInstruction = decoder.decodeObjectForKey("atAGlanceInstruction") as? String,
            let detoxFacts = decoder.decodeObjectForKey("detoxFacts") as? String,
            let tipOfTheDay = decoder.decodeObjectForKey("tipOfTheDay") as? String,
            let dailyInspiration = decoder.decodeObjectForKey("dailyInspiration") as? String else {
                print("Failed to decode a string in a daily plan")
                return nil
        }
        
        
        
        self.init(
            dayNum: decoder.decodeIntegerForKey("dayNumber"),
            meals: mealsArray,
            atAGlance: atAGlance,
            amountDrank: amountDrank,
            atAGlanceInstruction: atAGlanceInstruction,
            detoxFacts: detoxFacts,
            tipOfTheDay: tipOfTheDay,
            dailyInspiration: dailyInspiration
        )
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        //        aCoder.encodeObject(self.dayNumber, forKey: "dayNumber")
        aCoder.encodeInteger(self.dayNumber, forKey: "dayNumber")
        aCoder.encodeObject(self.meals, forKey: "meals")
        aCoder.encodeObject(self.atAGlance, forKey: "atAGlance")
        aCoder.encodeObject(self.amountDrank, forKey: "amountDrank")
        aCoder.encodeObject(self.atAGlanceInstruction, forKey: "atAGlanceInstruction")
        aCoder.encodeObject(self.detoxFacts, forKey:"detoxFacts")
        aCoder.encodeObject(self.tipOfTheDay, forKey:"tipOfTheDay")
        aCoder.encodeObject(self.dailyInspiration, forKey: "dailyInspiration")
        
    }
    
    func updateAmountDrank(amountDrank: Int){
        self.amountDrank = amountDrank
    }
}
