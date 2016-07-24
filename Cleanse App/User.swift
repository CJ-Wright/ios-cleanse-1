//
//  User.swift
//  Cleanse App
//
//  Created by Erik Karlsson on 6/25/16.
//  Copyright © 2016 Nano Nimbus. All rights reserved.
//

import Foundation

class User {
    var userName: String!
    var userPassword: String!
    var sessionAuthToken: String!
    var apiKey: String!
    
    let session: NSURLSession = {
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        return NSURLSession(configuration: config)
    }()
    
    func login(){
        
        let url = DjoserAPI.loginURL()
        
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        
        
        let data = "username=\(self.userName)&password=\(self.userPassword)".dataUsingEncoding(NSUTF8StringEncoding)
        
        
        let task = session.uploadTaskWithRequest(request, fromData: data, completionHandler:
            {(data,response,error) in
                
                guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
                    print("error")
                    return
                }
                
                let dataString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print(dataString)
                self.sessionAuthToken = String(dataString)
            }
        );
        task.resume()
    }
    
    
}