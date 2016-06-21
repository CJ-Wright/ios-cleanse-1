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
    
    var loremIpsum = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    
    var ingredients: [String] = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ingredientsListLabel.text = ""
        
        for item in ingredients {
            let leftAlignment = NSTextAlignment.Left
            ingredientsListLabel.textAlignment = leftAlignment
            ingredientsListLabel.text! += "• " + item + "\n"
            ingredientsListLabel.numberOfLines += 1
        }
        
        recipeDescription.text = loremIpsum
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
