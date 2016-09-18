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
    var mealIndex: Int = 0
    var dailyPlanIndex: Int = 0
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

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return recipeArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create a template cell as a MealMapTableViewCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for:indexPath) as! ChangeRecipeTableViewCell
        
        cell.recipeImageView.image = recipeArray[(indexPath as NSIndexPath).row].image
        cell.recipeNameLabel.text = recipeArray[(indexPath as NSIndexPath).row].name
        
        return cell
    }
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        for recipe in recipeSet {
            if recipeNames.contains(recipe.name) == false {
                recipeArray.append(recipe)
                recipeNames.append(recipe.name)
            }
        }
    }
    
    //Called, when long press occurred
    func longPress(_ longPressGestureRecognizer: UILongPressGestureRecognizer){
        
        if longPressGestureRecognizer.state == UIGestureRecognizerState.began {
            let touchPoint = longPressGestureRecognizer.location(in: self.view)
            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
                // Alert Controller / Modal for selecting a new recipes
                let alertController = UIAlertController(title: "", message: "Use selected recipe?", preferredStyle: .actionSheet)
                
                // Cancel the Modal
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
                    action in
                    print("Cancel pressed")
                })
                
                // Change the recipe
                let changeRecipeAction = UIAlertAction(title: "Change", style: .default, handler: {
                    action in
                    print("Change recipe")
                    print("Changing Day \(self.dailyPlanIndex) and Meal Index \(self.mealIndex)")
                    let newRecipe = self.recipeArray[(indexPath as NSIndexPath).row]
                    print("BEFORE CHANGING RECIPE")
                    print("Recipe Name \(((MealPlanStore.currentMealPlan.days[self.dailyPlanIndex] as! DailyPlan).meals[self.mealIndex] as! Meal).recipe!.name)")

                    print("After changing recipe")
                    MealPlanStore.currentMealPlan.changeMealRecipe(newRecipe ,dailyPlanIndex: self.dailyPlanIndex, mealIndex: self.mealIndex)
                    
                    print("Recipe Name \(((MealPlanStore.currentMealPlan.days[self.dailyPlanIndex] as! DailyPlan).meals[self.mealIndex] as! Meal).recipe!.name)")
                    print("New Recipe Name " + self.recipeArray[(indexPath as NSIndexPath).row].name)
                })
                
                alertController.addAction(cancelAction)
                alertController.addAction(changeRecipeAction)
                
                alertController.popoverPresentationController?.sourceView = view
                present(alertController, animated: true, completion:nil)
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
    }
}
