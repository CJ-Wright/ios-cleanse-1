//
//  ChangeRecipeTableViewController.swift
//  Cleanse App
//
//  Created by Erik Karlsson on 9/10/16.
//  Copyright © 2016 Nano Nimbus. All rights reserved.
//

import UIKit

class ChangeRecipeTableViewController: UITableViewController {
    var recipeSet = RecipeStore.recipeSet
    var recipeArray = [Recipe]()
    var recipeNames = [String]()
    var meal: Meal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // create a longPressRecognizer that is used for bringing up the modal to select recipes and marking the meal as eaten
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(MealMapTableViewController.longPress(_:)))
        self.view.addGestureRecognizer(longPressRecognizer)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return recipeArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Create a template cell as a MealMapTableViewCell
        let cell = tableView.dequeueReusableCellWithIdentifier("RecipeCell", forIndexPath:indexPath) as! ChangeRecipeTableViewCell
        
        cell.recipeImageView.image = recipeArray[indexPath.row].image
        cell.recipeNameLabel.text = recipeArray[indexPath.row].name
        
        return cell
    }
 
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        for recipe in recipeSet {
            if recipeNames.contains(recipe.name) == false {
                recipeArray.append(recipe)
                recipeNames.append(recipe.name)
            }
        }
    }
    
    //Called, when long press occurred
    func longPress(longPressGestureRecognizer: UILongPressGestureRecognizer){
        
        //
        if longPressGestureRecognizer.state == UIGestureRecognizerState.Began {
            let touchPoint = longPressGestureRecognizer.locationInView(self.view)
            if let indexPath = tableView.indexPathForRowAtPoint(touchPoint) {
                // Alert Controller / Modal for selecting a new recipes
                let alertController = UIAlertController(title: "Select Recipe", message: "Use selected recipe?", preferredStyle: .ActionSheet)
                
                // Cancel the Modal
                let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
                    action in
                    print("Cancel pressed")
                })
                
                // Change the recipe
                let changeRecipeAction = UIAlertAction(title: "Change", style: .Default, handler: {
                    action in
                    print("Change recipe")
                    self.meal?.recipe = self.recipeArray[indexPath.row]
                })
                
                alertController.addAction(cancelAction)
                alertController.addAction(changeRecipeAction)
                
                alertController.popoverPresentationController?.sourceView = view
                presentViewController(alertController, animated: true, completion:nil)
            }
        }
    }
    
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
