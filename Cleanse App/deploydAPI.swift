//
//  deploydAPI.swift
//  Cleanse App
//
//  Created by Erik Karlsson on 6/26/16.
//  Copyright © 2016 Nano Nimbus. All rights reserved.
//

import Foundation

enum Method: String {
    case Recipes = "recipes"
}

struct deploydAPI {
    // The base url of the server to make the requests from
    private static let baseURLString = "http://ec2-54-215-241-191.us-west-1.compute.amazonaws.com:3000"
    
    // Empty APIKey for the moment being
    private static let APIKey = ""
    
    
    // This function will return the url endpoint of the API server which is used for storing the Recipes and the Meal Plans
    private static func deploydURL(method method: Method, parameters: [String:String]?) -> NSURL {
        
        // Base component for the NSURL
        let components = NSURLComponents(string: baseURLString)!
        
        // Array of NSURLQuery Items to be sent along with the requests
        var queryItems = [NSURLQueryItem]()
        
        // This may not be needed to make rest calls for our application at the moment.
        let baseParams = [
            "method": method.rawValue,
            "format": "json",
        ]
        /* Once the API key has been established then the key:value pair "api_key" : APIKey can be added to the baseParams array */
        
        for (key, value) in baseParams {
            let item = NSURLQueryItem(name: key, value: value)
            queryItems.append(item)
        }
        
        // This will append any additional items given for when requesting the URL for the deployd server
        if let additionalParams = parameters {
            for(key, value) in additionalParams {
                let item = NSURLQueryItem(name: key, value: value)
                queryItems.append(item)
            }
        }
        return components.URL!
    }
    
    static func recipesURL() -> NSURL {
        return deploydURL(method: .Recipes, parameters: [:])
    }
}