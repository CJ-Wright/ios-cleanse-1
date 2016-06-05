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
    
    var loremIpsum = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeDescription.text = loremIpsum
    }
    
    // MARK: - Label Methods
    func addIngredient(ingredient: String) {

    }
    
    // MARK: - TableView Methods
    
}
