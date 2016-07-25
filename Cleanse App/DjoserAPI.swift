//
//  DjoserAPI.swift
//  Cleanse App
//
//  Created by Erik Karlsson on 7/24/16.
//  Copyright © 2016 Nano Nimbus. All rights reserved.
//

import Foundation

enum RegisterResult {
    case Success(AuthToken)
    case Failure(ErrorType)
}

enum AuthToken {
    case String
}

struct DjoserAPI {
    // Development environment
//    private static let baseURLString = "http://localhost:8000"
    private static let baseURLString = "http://dev-djoser-postgres.cjv0rqkpv8ys.us-west-1.rds.amazonaws.com:8000"
    
    // This function will return the url endpoint of the API server which is used for storing the Recipes and the Meal Plans
    private static func djoserURL(method method: Method, parameters: [String:String]?) -> NSURL {
        
        // Base component for the NSURL
        let components = NSURLComponents(string: baseURLString)!
        
        // Array of NSURLQuery Items to be sent along with the requests
        var queryItems = [NSURLQueryItem]()
        
        // This may not be needed to make rest calls for our application at the moment.
        let baseParams = [
            "format": "json"
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

    
    static func registerURL() -> NSURL {
        
        // Base URL with the recipes API request call appended to the end of it
        let components = NSURLComponents(string: baseURLString + "/auth/register/")!
        var queryItems = [NSURLQueryItem]()
        
        // Base parameters
        let baseParams = [
            "format": "json"
        ]
        /* Once the API key has been established then the key:value pair "api_key" : APIKey can be added to the baseParams array */
        
        // Append the base parameters to the NSQueryItems array
        for (key, value) in baseParams {
            let item = NSURLQueryItem(name: key, value: value)
            queryItems.append(item)
        }
        
        return components.URL!
    }
    
    static func loginURL() -> NSURL {
        
        // Base URL with the recipes API request call appended to the end of it
        let components = NSURLComponents(string: baseURLString + "/auth/login/")!
        var queryItems = [NSURLQueryItem]()
        
        // Base parameters
        let baseParams = [
            "format": "json"
        ]
        /* Once the API key has been established then the key:value pair "api_key" : APIKey can be added to the baseParams array */
        
        // Append the base parameters to the NSQueryItems array
        for (key, value) in baseParams {
            let item = NSURLQueryItem(name: key, value: value)
            queryItems.append(item)
        }
        
        return components.URL!
    }
       
}