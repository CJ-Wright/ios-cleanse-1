//
//  UserStore.swift
//  Cleanse App
//
//  Created by Erik Karlsson on 8/6/16.
//  Copyright © 2016 Nano Nimbus. All rights reserved.
//

import Foundation

class UserStore {
    
    let userArchiveURL: URL = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("user.archive")
    }()
    
    func load() -> User? {
        guard let user = NSKeyedUnarchiver.unarchiveObject(withFile: userArchiveURL.path) as? User else { return nil }
        return user
    }
    
    func save(_ user:User) -> Bool{
        return NSKeyedArchiver.archiveRootObject(user, toFile: userArchiveURL.path)
    }
}
