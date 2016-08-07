//
//  Recipe.swift
//  Cleanse App
//
//  Created by Erik Karlsson on 6/2/16.
//  Copyright © 2016 Nano Nimbus. All rights reserved.
//

import UIKit

// MARK: - Recipe Class
class Recipe: NSObject, NSCoding {
    
    // MARK: Data Members
    var name: String
    var instructions: String
    var image: UIImage?
    var ingredients: [String]
    var recipeID: String
    var serves: String
    
    override init () {
        self.recipeID = ""
        self.name = ""
        self.instructions = ""
        self.ingredients = [String]()
        self.serves = ""
    }
    
    init (name: String, instructions: String, ingredients: [String], recipeID: String, serves: String){
        self.name = name
        self.instructions = instructions
        self.ingredients = ingredients
        self.recipeID = recipeID
        self.serves = serves
    }
 
    // MARK: NSCoding
    required convenience init?(coder decoder: NSCoder){
        guard let name = decoder.decodeObjectForKey("name") as? String,
            let instructions = decoder.decodeObjectForKey("instructions") as? String,
            let image = decoder.decodeObjectForKey("image") as? UIImage,
            let ingredients = decoder.decodeObjectForKey("ingredients") as? [String],
            let recipeID = decoder.decodeObjectForKey("recipeID") as? String,
            let serves = decoder.decodeObjectForKey("serves") as? String else {
                print("Failed to init user from archiver")
                return nil
                
        }
        
        self.init(
            name:name,
            instructions: instructions,
            ingredients: ingredients,
            recipeID: recipeID,
            serves: serves
        )
        self.image = image
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.name, forKey: "name")
        aCoder.encodeObject(self.instructions, forKey: "instructions")
        aCoder.encodeObject(self.image, forKey: "image")
        aCoder.encodeObject(self.ingredients, forKey: "ingredients")
        aCoder.encodeObject(self.recipeID, forKey: "recipeID")
        aCoder.encodeObject(self.serves, forKey: "serves")
    }
}