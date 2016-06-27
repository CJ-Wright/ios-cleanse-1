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
    
    // MARK: Default Ingredients for testing purposes only!
    var default_instructions = "Preheat the oven to 375 degrees Fahrenheit. In a large pot combine the broth, onion," +
        "carrots, celery, and 1 tablespoon of the parsley (or cilantro), and garlic. Add 2 cups of" +
        "water and bring to a boil. Add the rice and bring back to a boil. Cover and simmer for" +
        "25 minutes. Remove the lid and simmer for 5 more minutes. Set aside." + "\n\n" +
        "While the rice cooks, put the chicken and broccoli in a mixing bowl. Add the lime" +
        "juice, ½ teaspoon parsley, salt, and pepper. Mix well until the chicken and broccoli are" +
        "coated with the ﬂavorings. Transfer the chicken and broccoli mixture to a baking pan," +
        "spreading it evenly across the bottom with a spatula. Bake for 30 to 35 minutes." + "\n\n" +
        "Remove the chicken from the oven and allow to cool. Divide chicken and broccoli into" +
        "four equal portions and place each over 1 cup of the rice/veggie mixture. Serve and" +
    "enjoy. (Don’t hesitate to double this recipe and freeze leftover portions.)"
    
    var default_ingredients: [String] = [
        "4 cups vegetable or chicken broth", "½ cup chopped red onion", "½ cup chopped carrot", "½ cup chopped celery",
        "1 tablespoon plus ½ teaspoon chopped parsley or cilantro",
        "1 teaspoon minced garlic",
        "1 pound skinless, boneless chicken",
        "breast, chopped into 2-inch pieces",
        "4 cups broccoli",
        "1 tablespoon lime juice",
        "½ teaspoon sea salt",
        "½ teaspoon black pepper",
        "1 cup brown rice"
    ]
    
    var default_recipeTitle = "Chicken and Broccoli Bowl"
    
    
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
    
    // MARK: Testing methods
    func init_defaults(){
        self.name = default_recipeTitle
        self.instructions = default_instructions
        self.ingredients = default_ingredients
    }
}