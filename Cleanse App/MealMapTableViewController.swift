//
//  MealMapTableViewController.swift
//  Cleanse App
//
//  Created by Erik Karlsson on 6/24/16.
//  Copyright © 2016 Nano Nimbus. All rights reserved.
//

import UIKit


class MealMapTableViewController: UITableViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet var navigationBar: UINavigationItem!
    @IBOutlet var menuButton: UIBarButtonItem!
    var recipeStore: RecipeStore!
    var mealPlanStore: MealPlanStore!
    var currentDay = 1
    var numDaysInPlan = 10
    
    let cellIdentifiers = ["Breakfast","Snack","Lunch","Snack","Dinner"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.title = "Day " + String(currentDay)
        
        // Checks to see if the recipe store and meal plan store has been already configured
        if !RecipeStore.recipesReceived && !MealPlanStore.plansReceived {
            recipeStore = RecipeStore.sharedInstance
            mealPlanStore = MealPlanStore.sharedInstance
            
            // Attempt to fetch the Meal Plans
            mealPlanStore.fetchMealPlans(){
                (mealPlanResult) -> Void in
                
                switch mealPlanResult {
                case let .Success(mealPlan):
                    print("Successfully found \(mealPlan)")
                    MealPlanStore.plansReceived = true
                    
                    // This is how you can access the mealPlan, however it is only accessible within this scope
                    //  need to plan out how to parse information out for the tableview.
                    //  - Also think ahead of how to cache / save this information and load it from stored memory instead
                    //  calling to load the information.
                    print("Plan name \(mealPlan[0].mealPlanName)")
                case let .Failure(error):
                    print("Error fetching recipes: \(error)")
                    MealPlanStore.plansReceived = false
                }
            }
            
            // Attempt to fetch the recipes
            recipeStore.fetchRecipes() {
                (recipeResult) -> Void in
                
                switch recipeResult {
                case let .Success(recipes):
                    print("Successfully found \(recipes)")
                    RecipeStore.recipesReceived = true
                case let .Failure(error):
                    print("Error fetching recipes: \(error)")
                    RecipeStore.recipesReceived = false
                }
            }
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        // This allows for the side menu to appear from within the app
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
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
        return 5
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell",forIndexPath:indexPath) as! MealMapTableViewCell
        
        if cellIdentifiers[indexPath.row] == "Snack" {
            cell.mealMapImageView.image = UIImage(named: "Shaker_Bottle")
        } else if cellIdentifiers[indexPath.row] != "DAY" {
            cell.mealMapImageView.image = UIImage(named: "Asian_Turkey_SoupFS")
        }
        
        
        cell.mealMapNameLabel.text = cellIdentifiers[indexPath.row]
        
        return cell
    }
    
    
    @IBAction func nextDayButton(sender: UIBarButtonItem) {
        print("Next day " + navigationBar.title!)
        if currentDay < numDaysInPlan {
            currentDay += 1
            
            navigationBar.title! = "Day " + String(currentDay)
            
            // This will animate the movement of the table right to left
            let range = NSMakeRange(0, self.tableView.numberOfSections)
            let sections = NSIndexSet(indexesInRange: range)
            self.tableView.reloadSections(sections, withRowAnimation: .Left)
        }
        
    }
    @IBAction func previousDayButton(sender: UIBarButtonItem) {
        print("Previous day " + navigationBar.title!)
        if currentDay > 1{
            currentDay -= 1
            
            navigationBar.title! = "Day " + String(currentDay)
            
            // This will animate the movement of the table left to right
            let range = NSMakeRange(0, self.tableView.numberOfSections)
            let sections = NSIndexSet(indexesInRange: range)
            self.tableView.reloadSections(sections, withRowAnimation: .Right)
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
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        // Check to see if the segue that's happening is going to the detail view of the recipes
        if segue.identifier == "recipeDetailSegue" {
            
        }
    }
    
}

