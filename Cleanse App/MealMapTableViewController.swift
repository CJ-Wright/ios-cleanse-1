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
    var recipeStore = RecipeStore.sharedInstance
    var mealPlanStore = MealPlanStore.sharedInstance
    // This will need to be initialized when the plan is loaded from the users information
    var currentDay = 1
    var numDaysInPlan = 10
    
    let cellIdentifiers = ["Breakfast","Snack","Lunch","Snack","Dinner"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        recipeStore.initRecipes()
        //        mealPlanStore.initMealPlan()
        // TODO: Should correspond to the day that the user is currently on in the plan
        //        navigationBar.title = "Day " + String(currentDay)
        
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
        var mealName: String = "None"
        var image: UIImage?
        if cellIdentifiers[indexPath.row] == "Snack" {
//            cell.mealMapImageView.image = UIImage(named: "Shaker_Bottle")
            if MealPlanStore.currentMealPlan.days.count > 0 {
                if let day = MealPlanStore.currentMealPlan.days[currentDay-1] as? DailyPlan {
                    //                    print("Meal \(indexPath.row) [\(day.meals![indexPath.row].mealName)]")
                    //                    print("Image url is \(day.meals![indexPath.row].mealImageUrl)")
                    image = day.meals![indexPath.row].mealImage
                    mealName = day.meals![indexPath.row].mealName
                }
            }
        } else if cellIdentifiers[indexPath.row] != "DAY" {
            
            if MealPlanStore.currentMealPlan.days.count > 0 {
                if let day = MealPlanStore.currentMealPlan.days[currentDay-1] as? DailyPlan {
                    navigationBar.title! = "Day " + String(day.dayNumber)
                    //                    print("Meal \(indexPath.row) [\(day.meals![indexPath.row].mealName)]")
                    //                    print("Image url is \(day.meals![indexPath.row].mealImageUrl)")
                    image = day.meals![indexPath.row].mealImage
                    mealName = day.meals![indexPath.row].mealName
                }
            }
//            cell.mealMapImageView.image = UIImage(named: "Asian_Turkey_SoupFS")
        }
        cell.mealMapNameLabel.numberOfLines = 3
        cell.mealMapNameLabel.text = cellIdentifiers[indexPath.row] + ":\n" + mealName
        cell.mealMapImageView.image = image
        
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
        if currentDay > 1 {
            
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
            print("Recipe Detail Segue")
            
            // Figure out which row was just tapped
            if let row = tableView.indexPathForSelectedRow?.row {
                // Get the item associated with this row and pass it along
                if let dailyPlan = MealPlanStore.currentMealPlan.days[currentDay-1] as? DailyPlan {
                    let meal = dailyPlan.meals![row]
                    let detailViewController = segue.destinationViewController as! MealDetailsTableViewController
                    detailViewController.meal = meal
                }
            }
        }
    }
}

