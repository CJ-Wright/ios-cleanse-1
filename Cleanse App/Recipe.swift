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
    var image: UIImage
    var imageURL: NSURL?
    var ingredients: NSMutableArray
    var recipeID: String
    var serves: String
    var numIngredients: Int
    
    override init () {
        self.imageURL = nil
        self.recipeID = ""
        self.name = ""
        self.instructions = ""
        self.ingredients = NSMutableArray()
        self.numIngredients = 0
        self.serves = ""
        self.image = UIImage()
    }
    
    init (name: String, instructions: String, ingredients: NSMutableArray, recipeID: String, serves: String, imageURL: NSURL){
        self.name = name
        self.image = UIImage()
        self.instructions = instructions
        self.ingredients = NSMutableArray()
        for ingredient in ingredients {
            self.ingredients.addObject(ingredient)
        }
        self.numIngredients = ingredients.count
        self.recipeID = recipeID
        self.serves = serves
    }
    
    // MARK: NSCoding
    required convenience init?(coder decoder: NSCoder){
        guard let name = decoder.decodeObjectForKey("name") as? String  else {
            print("Failed to init name from recipe archiver")
            return nil
        }
        guard let instructions = decoder.decodeObjectForKey("instructions") as? String  else {
            print("Failed to init instructions from recipe archiver")
            return nil
        }
        guard let image = decoder.decodeObjectForKey("image") as? UIImage  else {
            print("Failed to init image from recipe archiver")
            return nil
        }
        guard let ingredients = decoder.decodeObjectForKey("ingredients") as? NSMutableArray  else {
            print("Failed to init ingredients from recipe archiver")
            return nil
        }
        guard let recipeID = decoder.decodeObjectForKey("recipeID") as? String  else {
            print("Failed to init recipeID from recipe archiver")
            return nil
        }
        guard let serves = decoder.decodeObjectForKey("serves") as? String else {
            print("Failed to init serves from recipe archiver")
            return nil
        }
        guard let imageURL = decoder.decodeObjectForKey("imageURL") as? NSURL else {
            print("Failed to init imageURL from recipe archiver")
            return nil
        }
        self.init(
            name:name,
            instructions: instructions,
            ingredients: ingredients,
            recipeID: recipeID,
            serves: serves,
            imageURL: imageURL
        )
        self.image = image
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.name, forKey: "name")
        aCoder.encodeObject(self.instructions, forKey: "instructions")
        aCoder.encodeObject(self.image, forKey: "image")
        aCoder.encodeObject(self.ingredients, forKey: "ingredients")
        aCoder.encodeObject(self.recipeID, forKey: "recipeID")
        print("Encoding serves \(self.serves)")
        aCoder.encodeObject(self.serves, forKey: "serves")
        aCoder.encodeObject(self.imageURL, forKey: "imageURL")
    }
}
