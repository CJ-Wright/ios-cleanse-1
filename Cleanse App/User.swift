//
//  User.swift
//  Cleanse App
//
//  Created by Erik Karlsson on 6/25/16.
//  Copyright © 2016 Nano Nimbus. All rights reserved.
//

import Foundation

class User: NSObject, NSCoding {
    var userName: String!
    var sessionAuthToken: String!
    var apiKey: String!
    var hasCurrentPlan: Bool
    
    let session: NSURLSession = {
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        return NSURLSession(configuration: config)
    }()
    
    init(name:String, hasPlan:Bool){
        self.userName = name
        self.hasCurrentPlan = hasPlan
    }
    
    required convenience init?(coder decoder: NSCoder){
        guard let name = decoder.decodeObjectForKey("userName") as? String
            else { return nil }
        
        self.init(
            name: name,
            hasPlan: decoder.decodeBoolForKey("hasPlan")
        )
    }
    
    func hasPlan() -> Bool {
        return self.hasCurrentPlan
    }
    
    func setPlanState(state:Bool){
        self.hasCurrentPlan = state
    }
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.userName, forKey: "userName")
        aCoder.encodeBool(self.hasCurrentPlan, forKey: "hasPlan")
    }
 
    
}