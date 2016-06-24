//
//  MealDetailsViewController.swift
//  Cleanse App
//
//  Created by Erik Karlsson on 6/2/16.
//  Copyright © 2016 Nano Nimbus. All rights reserved.
//

import UIKit

class MealDetailsViewController: UIViewController, UITableViewDelegate {
    
    // MARK: - Data Members
    @IBOutlet var recipeNameLabel: UILabel!
    @IBOutlet var mealImage: UIImageView!
    @IBOutlet var recipeDescription: UITextView!
    @IBOutlet var ingredientsListLabel: UILabel!
    
    // Stores the JSON representation of the recipes.
    var recipesJSON: AnyObject!
    
    var instructions = "Preheat the oven to 375 degrees Fahrenheit. In a large pot combine the broth, onion," +
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
    
    var ingredients: [String] = [
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
    
    var recipeTitle = "Chicken and Broccoli Bowl"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mealImage.layer.cornerRadius = 8.0
        mealImage.clipsToBounds = true
        
        mealImage.layer.borderWidth = 3.0;
        mealImage.layer.borderColor = UIColor .whiteColor().CGColor
        
        ingredientsListLabel.text = ""
        
        for item in ingredients {
            let leftAlignment = NSTextAlignment.Left
            ingredientsListLabel.textAlignment = leftAlignment
            ingredientsListLabel.text! += "• " + item + "\n"
            ingredientsListLabel.numberOfLines += 1
        }
        
        recipeDescription.text = instructions
//        recipeDescription.font = recipeDescription.font?.fontWithSize(200)
        recipeDescription.font = .systemFontOfSize(16)
        
    }
    
    // MARK: - Label Methods
    func addIngredient(ingredient: String) {
        
    }
    
    // MARK: - TableView Methods
    
    // MARK: - Data Methods
    func recipesFromJSON(data: NSData){
//        let path = NSBundle.mainBundle().URLForResource("recipes", withExtension: "json")
//        let data = NSData(contentsOfURL: path!)
//
//        do {
//            let jsonObject: AnyObject = try NSJSONSerialization.JSONObjectWithData(data, options: [])
//            print(jsonObject)
//            print("Loaded JSON!")
//        } catch let error {
//            return .Failure(error)
//        }
    }
}
