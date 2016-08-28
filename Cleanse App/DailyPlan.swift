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
    
    override init(){
        self.dayNumber = 0
        self.meals = NSMutableArray()
        self.atAGlance = NSMutableArray()
    }
    
    init(dayNum: Int, meals: NSMutableArray, atAGlance: NSMutableArray){
        self.dayNumber = dayNum
        self.meals = NSMutableArray()
        self.atAGlance = NSMutableArray()
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
        
        self.init(
            dayNum: decoder.decodeIntegerForKey("dayNumber"),
            meals: mealsArray,
            atAGlance: atAGlance
        )
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        //        aCoder.encodeObject(self.dayNumber, forKey: "dayNumber")
        aCoder.encodeInteger(self.dayNumber, forKey: "dayNumber")
        aCoder.encodeObject(self.meals, forKey: "meals")
        aCoder.encodeObject(self.atAGlance, forKey: "atAGlance")
        
    }
}
