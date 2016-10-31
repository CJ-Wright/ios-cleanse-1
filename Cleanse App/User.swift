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
    
    let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    init(name:String, hasPlan:Bool){
        self.userName = name
        self.hasCurrentPlan = hasPlan
    }
    
    required convenience init?(coder decoder: NSCoder){
        guard let name = decoder.decodeObject(forKey: "userName") as? String
            else { return nil }
        
        self.init(
            name: name,
            hasPlan: decoder.decodeBool(forKey: "hasPlan")
        )
    }
    
    func hasPlan() -> Bool {
        return self.hasCurrentPlan
    }
    
    func setPlanState(_ state:Bool){
        self.hasCurrentPlan = state
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.userName, forKey: "userName")
        aCoder.encode(self.hasCurrentPlan, forKey: "hasPlan")
    }
 
    
}
