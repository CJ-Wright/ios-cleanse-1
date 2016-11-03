//
//  RecipeSet.swift
//  Cleanse App
//
//  Created by Erik Karlsson on 11/2/16.
//  Copyright © 2016 Nano Nimbus. All rights reserved.
//

import Foundation

class RecipeSet: NSObject, NSCoding {
    var setName:String
    var recipes: NSMutableArray
    let recipeSetArchiveURL: URL
    
    override init(){
        self.setName = ""
        self.recipes = NSMutableArray()
        
    }
    
    init(setName: String, recipes: NSMutableArray) {
        self.setName = setName
        self.recipes = recipes
        self.recipeSetArchiveURL = setRecipeSetURL()
    }
    
    func setRecipeSetURL() -> URL {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("recipeSet.\(setName).archive")
    }
    
    
    required convenience init?(coder decoder: NSCoder){
        guard let setName = decoder.decodeObject(forKey: "setName") as? String,
            let recipes = decoder.decodeObject(forKey: "recipes") as? NSMutableArray
            else {
                return nil
        }
        
        self.init(setName: setName, recipes: recipes)
    }
}
