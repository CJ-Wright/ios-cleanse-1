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
    
    var meal: Meal!
    var numIngredients: Int = 0
    
    let cellTypes = ["recipeNameCell","recipeImagesCell","recipeIngredientsCell","recipeInstructionsCell"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.estimatedRowHeight = 140 // set to whatever your "average" cell height is
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.setNeedsLayout()
        self.tableView.layoutIfNeeded()
        let leftAlignment = NSTextAlignment.Left
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.recipeIngredientsLabel.textAlignment = leftAlignment
        /*
         for ingredient in ingredients {
         self.recipeIngredientsLabel.text? += "• " + ingredient
         self.recipeIngredientsLabel.text? += "\n"
         }
         */
        self.recipeInstructionsLabel.font = .systemFontOfSize(15)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var returnHeight:CGFloat
        switch(indexPath.row)
        {
        case 0:
            returnHeight = 44
        case 1:
            returnHeight = 200
        case 2:
            returnHeight = 100 + 10*CGFloat(meal.recipe!.numIngredients)
        case 3:
            returnHeight = 500// - 10*CGFloat(meal.recipe!.numIngredients)
        default:
            returnHeight = 30
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
        cell.sizeToFit()
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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if meal != nil {
            self.recipeNameLabel.text           = meal.recipe?.name
            self.recipeImageView.image          = meal.recipe?.image
            
            self.recipeInstructionsLabel.text   = meal.recipe?.instructions
            self.recipeNameLabel.adjustsFontSizeToFitWidth = true
            var ingredientsList: String = ""
            for ingredient in (meal.recipe?.ingredients)! {
                print(ingredient)
                ingredientsList = ingredientsList + "\n* " + (ingredient as! String)
                numIngredients += 1
            }
            self.recipeIngredientsLabel.text = ingredientsList
        }
    }
}
