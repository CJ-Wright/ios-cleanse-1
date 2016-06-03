//
//  Recipe.swift
//  Cleanse App
//
//  Created by Erik Karlsson on 6/2/16.
//  Copyright © 2016 Nano Nimbus. All rights reserved.
//

import UIKit

// MARK: - Ingredient Struct
struct Ingredient {
    var name: String
    var amount: Float
}

// MARK: - Recipe Class
class Recipe: NSObject {
    
    // MARK: Data Members
    var name: String
    var desc: String
    var ingredients: [Ingredient]
    var image: UIImage?
    
    init (name: String, description: String, ingredients: [Ingredient]) {
        self.name = name
        self.desc = description
        self.ingredients = ingredients
    }
}