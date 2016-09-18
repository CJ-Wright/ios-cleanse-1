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
            self.meals.add(meal)
        }
        for aString in atAGlance{
            self.atAGlance.add(aString)
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
        
        self.init(
            dayNum: decoder.decodeInteger(forKey: "dayNumber"),
            meals: mealsArray,
            atAGlance: atAGlance
        )
    }
    
    func encode(with aCoder: NSCoder) {
        //        aCoder.encodeObject(self.dayNumber, forKey: "dayNumber")
        aCoder.encode(self.dayNumber, forKey: "dayNumber")
        aCoder.encode(self.meals, forKey: "meals")
        aCoder.encode(self.atAGlance, forKey: "atAGlance")
        
    }
}
