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
    var imageURL: URL?
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
    
    init (name: String, instructions: String, ingredients: NSMutableArray, recipeID: String, serves: String, imageURL: URL){
        self.name = name
        self.image = UIImage()
        self.instructions = instructions
        self.ingredients = NSMutableArray()
        for ingredient in ingredients {
            self.ingredients.add(ingredient)
        }
        self.numIngredients = ingredients.count
        self.recipeID = recipeID
        self.serves = serves
    }
    
    // MARK: NSCoding
    required convenience init?(coder decoder: NSCoder){
        guard let name = decoder.decodeObject(forKey: "name") as? String  else {
            print("Failed to init name from recipe archiver")
            return nil
        }
        guard let instructions = decoder.decodeObject(forKey: "instructions") as? String  else {
            print("Failed to init instructions from recipe archiver")
            return nil
        }
        guard let image = decoder.decodeObject(forKey: "image") as? UIImage  else {
            print("Failed to init image from recipe archiver")
            return nil
        }
        guard let ingredients = decoder.decodeObject(forKey: "ingredients") as? NSMutableArray  else {
            print("Failed to init ingredients from recipe archiver")
            return nil
        }
        guard let recipeID = decoder.decodeObject(forKey: "recipeID") as? String  else {
            print("Failed to init recipeID from recipe archiver")
            return nil
        }
        guard let serves = decoder.decodeObject(forKey: "serves") as? String else {
            print("Failed to init serves from recipe archiver")
            return nil
        }
        guard let imageURL = decoder.decodeObject(forKey: "serves") as? URL else {
            print("Failed to init serves from recipe archiver")
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
//        self.image = image
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.instructions, forKey: "instructions")
        aCoder.encode(self.image, forKey: "image")
        aCoder.encode(self.ingredients, forKey: "ingredients")
        aCoder.encode(self.recipeID, forKey: "recipeID")
        aCoder.encode(self.serves, forKey: "serves")
        aCoder.encode(self.imageURL, forKey: "imageURL")
    }
}
