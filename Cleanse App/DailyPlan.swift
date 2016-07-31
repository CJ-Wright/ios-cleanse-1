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
    var meals: [Meal]?
    var atAGlance: [String]
    
    override init(){
        self.dayNumber = 0
        self.meals = [Meal]()
        self.atAGlance = [String]()
    }
    
    init(dayNum: Int,inout  meals: [Meal], atAGlance: [String]){
        self.dayNumber = dayNum
        self.meals = meals
        self.atAGlance = atAGlance
    }
    
    // MARK: NSCoding
    required convenience init?(coder decoder: NSCoder) {
        guard let meals = decoder.decodeObjectForKey("meals") as? [Meal],
            let atAGlance = decoder.decodeObjectForKey("atAGlace") as? [String]
            else {
                return nil
        }
        
        self.init(
            dayNum: decoder.decodeIntegerForKey("dayNumber"),
            meals: meals,
            atAGlance: atAGlance
        )
    }
}
