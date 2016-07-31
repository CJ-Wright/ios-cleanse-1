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
//    var meals: [Meal]?
    var meals:NSMutableArray
    var atAGlance: [String]
    
    override init(){
        self.dayNumber = 0
//        self.meals = [Meal]()
        self.meals = NSMutableArray()
        self.atAGlance = [String]()
    }
    
    init(dayNum: Int, meals: NSMutableArray, atAGlance: [String]){
        self.dayNumber = dayNum
//        self.meals = meals
        self.meals = NSMutableArray()
        for meal in meals {
            self.meals.addObject(meal)
        }
        self.atAGlance = atAGlance
    }
    
    // MARK: NSCoding
    
    required convenience init?(coder decoder: NSCoder) {
//        guard let meals = decoder.decodeObjectForKey("meals") as? [Meal],
        guard let mealsArray = decoder.decodeObjectForKey("meals") as? NSMutableArray,
            let atAGlance = decoder.decodeObjectForKey("atAGlace") as? [String]
            else {
                return nil
        }
        
        self.init(
            dayNum: decoder.decodeIntegerForKey("dayNumber"),
            meals: mealsArray,
            atAGlance: atAGlance
        )
    }
 
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.dayNumber, forKey: "dayNumber")
        aCoder.encodeObject(self.meals, forKey: "meals")
        aCoder.encodeObject(self.atAGlance, forKey: "atAGlance")
        
    }
}
