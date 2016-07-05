//
//  Recipe.swift
//  Cleanse App
//
//  Created by Erik Karlsson on 6/2/16.
//  Copyright © 2016 Nano Nimbus. All rights reserved.
//

import UIKit

// MARK: - Recipe Class
class Recipe {
    
    // MARK: Data Members
    var name: String
    var instructions: String
    var image: UIImage?
    var ingredients: [String]
    var recipeID: String
    var serves: String
    
    init () {
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
    
}