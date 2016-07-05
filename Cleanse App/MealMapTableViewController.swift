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
        navigationBar.title! = "Meal Mapper"
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 79/255, green: 116/255, blue: 136/255, alpha: 1.0)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //         self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
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
            if MealPlanStore.currentMealPlan.days.count > 0 {
                if let day = MealPlanStore.currentMealPlan.days[currentDay-1] as? DailyPlan {
                    image = day.meals![indexPath.row].mealImage
                    mealName = day.meals![indexPath.row].mealName
                }
            }
        } else if cellIdentifiers[indexPath.row] != "DAY" {
            if MealPlanStore.currentMealPlan.days.count > 0 {
                if let day = MealPlanStore.currentMealPlan.days[currentDay-1] as? DailyPlan {
                    image = day.meals![indexPath.row].mealImage
                    mealName = day.meals![indexPath.row].mealName
                }
            }
        }
        cell.mealMapNameLabel.numberOfLines = 3
        cell.mealMapNameLabel.text = cellIdentifiers[indexPath.row] + ":\n" + mealName
        cell.mealMapImageView.image = image
        
        return cell
    }
    
    @IBAction func nextDayButton(sender: UIBarButtonItem) {
        
        if currentDay < numDaysInPlan {
            currentDay += 1
            
            // This will animate the movement of the table right to left
            let range = NSMakeRange(0, self.tableView.numberOfSections)
            let sections = NSIndexSet(indexesInRange: range)
            self.tableView.reloadSections(sections, withRowAnimation: .Left)
        }
    }
    @IBAction func previousDayButton(sender: UIBarButtonItem) {
        
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
    override func tableView(tableView: UITableView,
                            titleForHeaderInSection section: Int) -> String?{
        navigationBar.title! = "Meal Mapper"
        return "Day " + String(currentDay)
    }
    
    // This configures and edits the section header
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView //recast your view as a UITableViewHeaderFooterView
        header.contentView.backgroundColor = UIColor(red: 18/255, green: 68/255, blue: 104/255, alpha: 1.0) //make the background color light blue
        header.textLabel!.textColor = UIColor.whiteColor() //make the text white
        header.alpha = 0.5 //make the header transparent
        header.textLabel?.textAlignment = NSTextAlignment.Center
        
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
        button.backgroundColor = .greenColor()
        button.setTitle("Test Button", forState: .Normal)
        button.addTarget(self, action: #selector(buttonAction), forControlEvents: .TouchUpInside)
//        header.contentView.addSubview(button)
        //        self.view.addSubview(button)
    }
    func buttonAction(sender: UIButton!) {
        print("Button tapped")
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
