//
//  UserStore.swift
//  Cleanse App
//
//  Created by Erik Karlsson on 8/6/16.
//  Copyright © 2016 Nano Nimbus. All rights reserved.
//

import Foundation

class UserStore {
    
    let userArchiveURL: NSURL = {
        let documentsDirectories = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.URLByAppendingPathComponent("user.archive")!
    }()
    
    func load() -> User? {
        guard let user = NSKeyedUnarchiver.unarchiveObjectWithFile(userArchiveURL.path!) as? User else { return nil }
        return user
    }
    
    func save(user:User) -> Bool{
        return NSKeyedArchiver.archiveRootObject(user, toFile: userArchiveURL.path!)
    }
}
