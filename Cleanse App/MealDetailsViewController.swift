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
    @IBOutlet var recipeDescription: UILabel!
    @IBOutlet var ingredientsListLabel: UILabel!
    
    var loremIpsum = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    
    var ingredients: [String] = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientsListLabel.text = ""
        
        recipeDescription.numberOfLines = loremIpsum.characters.count / 10
        
        for item in ingredients {
            ingredientsListLabel.text! += "• " + item + "\n"
            ingredientsListLabel.numberOfLines += 1
        }
        
        
        recipeDescription.text = loremIpsum
        
        loadJSON()
    }
    
    // MARK: - Label Methods
    func addIngredient(ingredient: String) {

    }
    
    // MARK: - TableView Methods
    
    // MARK: - Data Methods
    func loadJSON(){
        if let path = NSBundle.mainBundle().pathForResource("recipes", ofType: "json") {
            print("Json successfully loaded!")
            print(path)
        } else {
            print("Failed!")
        }
    }
}
