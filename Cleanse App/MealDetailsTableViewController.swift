//
//  MealDetailsTableViewController.swift
//  Cleanse App
//
//  Created by Erik Karlsson on 6/24/16.
//  Copyright © 2016 Nano Nimbus. All rights reserved.
//

import UIKit

class MealDetailsTableViewController: UITableViewController {
    @IBOutlet var recipeNameLabel: UILabel!
    @IBOutlet var recipeImageView: UIImageView!
    @IBOutlet var recipeIngredientsLabel: UILabel!
    @IBOutlet var recipeInstructionsLabel: UILabel!
    
    // MARK: Meal Details Debug Variables
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
    
    
    let cellTypes = ["recipeNameCell","recipeImagesCell","recipeIngredientsCell","recipeInstructionsCell"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.estimatedRowHeight = 68 // set to whatever your "average" cell height is
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.setNeedsLayout()
        self.tableView.layoutIfNeeded()
        let leftAlignment = NSTextAlignment.Left
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.recipeNameLabel.text = recipeTitle
        self.recipeIngredientsLabel.text = ""
        
        self.recipeIngredientsLabel.textAlignment = leftAlignment
        for ingredient in ingredients {
                self.recipeIngredientsLabel.text? += "• " + ingredient
                self.recipeIngredientsLabel.text? += "\n"
        }
        
//        self.recipeInstructionsLabel.numberOfLines = 100
        self.recipeInstructionsLabel.text = instructions
        self.recipeInstructionsLabel.font = .systemFontOfSize(16)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var returnHeight:CGFloat
        if indexPath.row == 0 {
            returnHeight = 44
        } else if indexPath.row == 1 {
            returnHeight = 200
        } else if indexPath.row == 2 {
            returnHeight = 100 + (20 * CGFloat(self.ingredients.count))
        } else {
            returnHeight = 700 - (5 * CGFloat(self.ingredients.count))
        }
        return returnHeight;
    }
    // MARK: - Table view data source

    /*
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellTypes[indexPath.row], forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
