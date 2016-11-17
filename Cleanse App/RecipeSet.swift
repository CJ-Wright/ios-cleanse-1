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
    var setId:String
    let recipeSetArchiveURL: URL?
    
    override init(){
        self.setName = ""
        self.setId = ""
        self.recipes = NSMutableArray()
        self.recipeSetArchiveURL = nil
        
    }
    
    init(setName: String, recipes: NSMutableArray, id:String) {
        self.setName = setName
        self.recipes = recipes
        self.setId = id
        self.recipeSetArchiveURL = RecipeSet.setRecipeSetURL(setId: id)
    }
    
    static func setRecipeSetURL(setId:String) -> URL {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("recipeSet.\(setId).archive")
    }
    
    
    required convenience init?(coder decoder: NSCoder){
        guard let setName = decoder.decodeObject(forKey: "setName") as? String,
            let setId = decoder.decodeObject(forKey: "setId") as? String,
            let recipes = decoder.decodeObject(forKey: "recipes") as? NSMutableArray
            else {
                return nil
        }
        
        self.init(setName: setName, recipes: recipes, id: setId)
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.setName, forKey:"setName")
        aCoder.encode(self.recipes, forKey:"recipes")
        aCoder.encode(self.setId, forKey:"setId")
    }
    
    func saveChanges() -> Bool {
        return NSKeyedArchiver.archiveRootObject(self, toFile: (self.recipeSetArchiveURL?.path)!)
    }
}
