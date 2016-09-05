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
        self.tableView.tableFooterView = UIView()
        self.tableView.alwaysBounceVertical = false
        
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Proxima Nova", size: 17)!]
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 79/255, green: 116/255, blue: 136/255, alpha: 1.0)
        // create a longPressRecognizer that is used for bringing up the modal to select recipes and marking the meal as eaten
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(MealMapTableViewController.longPress(_:)))
        self.view.addGestureRecognizer(longPressRecognizer)
        navigationBar.title! = "Meal Map"
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //         self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        // This allows for the side menu to appear from within the app
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
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
        
        // Initialize the swipe left gesture to change days
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(MealMapTableViewController.nextDayButton(_:)))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(swipeLeft)
        
        // If the current day is 1 then allow the swipe right feature to bring out the side menu
        if currentDay == 1 {
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        } else {
            // Remove the ability to open up the side menu by swiping when it is not the first day.
            self.view.removeGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
            // Add the swipe right functionality to the view
            let swipeRight = UISwipeGestureRecognizer(target:self, action: #selector(MealMapTableViewController.previousDayButton(_:)))
            swipeRight.direction = UISwipeGestureRecognizerDirection.Right
            self.view.addGestureRecognizer(swipeRight)
        }
        
        // Create a template cell as a MealMapTableViewCell
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell",forIndexPath:indexPath) as! MealMapTableViewCell
        var mealName: String = "None"
        var image: UIImage?
        
        // Determine if the cell is to be a snack/shake or meal cell
        if cellIdentifiers[indexPath.row] == "Snack" {
            if MealPlanStore.currentMealPlan.days.count > 0 {
                if let day = MealPlanStore.currentMealPlan.days[currentDay-1] as? DailyPlan {
                    if let meal = day.meals[indexPath.row] as? Meal {
                        image = meal.mealImage
                        mealName = meal.mealName
                    }
                }
            }
        } else if cellIdentifiers[indexPath.row] != "DAY" {
            if MealPlanStore.currentMealPlan.days.count > 0 {
                if let day = MealPlanStore.currentMealPlan.days[currentDay-1] as? DailyPlan {
                    image = day.meals[indexPath.row].mealImage
                    mealName = day.meals[indexPath.row].mealName
                }
            }
        }
        
        cell.mealMapNameLabel.numberOfLines = 3
        cell.mealMapNameLabel.text = cellIdentifiers[indexPath.row] + ":\n" + mealName
        cell.mealMapImageView.image = image
        cell.sizeToFit()
        
        return cell
    }
    
    // Changes the current day to the next day in the meal plan
    @IBAction func nextDayButton(sender: UIBarButtonItem) {
        
        // Check to see if the current day is less than the number of days in a meal plan
        if currentDay < numDaysInPlan {
            currentDay += 1
            
            // This will animate the movement of the table right to left
            let range = NSMakeRange(0, self.tableView.numberOfSections)
            let sections = NSIndexSet(indexesInRange: range)
            self.tableView.reloadSections(sections, withRowAnimation: .Left)
        }
    }
    
    // Changes the current day to the previous day
    @IBAction func previousDayButton(sender: UIBarButtonItem) {
        
        // Check to see if the current day is greater than the first day in the meal plan
        if currentDay > 1 {
            currentDay -= 1
            // This will animate the movement of the table left to right
            let range = NSMakeRange(0, self.tableView.numberOfSections)
            let sections = NSIndexSet(indexesInRange: range)
            self.tableView.reloadSections(sections, withRowAnimation: .Right)
        }
    }
    
    // MARK: - Section Header Methods
    
    // Return the title of the section header. This will change based on the current
    //  day of the meal plan.
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
        navigationBar.title! = "Meal Map"
        return "Day " + String(currentDay)
    }
    
    // This configures and edits the section header
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        //recast your view as a UITableViewHeaderFooterView
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        //make the background color dark blue
        header.contentView.backgroundColor = UIColor(red: 18/255, green: 68/255, blue: 104/255, alpha: 1.0)
        header.textLabel!.textColor = UIColor.whiteColor() //make the text white
        header.textLabel?.textAlignment = NSTextAlignment.Center
        header.textLabel?.font
    }
    
    /*
     override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
     
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
     print("Moving cell")
     
     }
     
     
     
     // Override to support conditional rearranging of the table view.
     override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    //Called, when long press occurred
    func longPress(longPressGestureRecognizer: UILongPressGestureRecognizer){
        
        //
        if longPressGestureRecognizer.state == UIGestureRecognizerState.Began {
            let touchPoint = longPressGestureRecognizer.locationInView(self.view)
            if let indexPath = tableView.indexPathForRowAtPoint(touchPoint) {
                // Alert Controller / Modal for selecting a new recipes
                let alertController = UIAlertController(title: "Edit Meal", message: "Select a new recipe?", preferredStyle: .ActionSheet)
                
                // Cancel the Modal
                let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
                    action in
                    print("Cancel pressed")
                })
                
                // Change the recipe
                let changeRecipeAction = UIAlertAction(title: "Change Recipe", style: .Default, handler: {
                    action in
                    print("Change recipe")
                    
                    self.performSegueWithIdentifier("selectRecipeModal", sender: self)
                })
                
                alertController.addAction(cancelAction)
                alertController.addAction(changeRecipeAction)
                
                alertController.popoverPresentationController?.sourceView = view
                presentViewController(alertController, animated: true, completion:nil)
            }
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        // Check to see if the segue that's happening is going to the detail view of the recipes
        if segue.identifier == "recipeDetailSegue" {
            
            // Figure out which row was just tapped
            if let row = tableView.indexPathForSelectedRow?.row {
                // Get the item associated with this row and pass it along
                if MealPlanStore.currentMealPlan.days.count > 0 {
                    if let dailyPlan = MealPlanStore.currentMealPlan.days[currentDay-1] as? DailyPlan {
                        let meal = dailyPlan.meals[row]
                        let detailViewController = segue.destinationViewController as! MealDetailsTableViewController
                        detailViewController.meal = meal as! Meal
                    }
                }
            }
        } else if segue.identifier == "selectRecipeModal" {
            print("Selecting new recipes")
            
        }
    }
}
