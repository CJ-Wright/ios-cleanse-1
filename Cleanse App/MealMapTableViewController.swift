//
//  MealMapTableViewController.swift
//  Cleanse App
//
//  Created by Erik Karlsson on 6/24/16.
//  Copyright © 2016 Nano Nimbus. All rights reserved.
//

import UIKit


class MealMapTableViewController: UITableViewController, UIGestureRecognizerDelegate{
    
    @IBOutlet var navigationBar: UINavigationItem!
    @IBOutlet var menuButton: UIBarButtonItem!
    var recipeStore = RecipeStore.sharedInstance
    var mealPlanStore = MealPlanStore.sharedInstance
    // This will need to be initialized when the plan is loaded from the users information
    var currentDay = 1
    var numDaysInPlan = 10
    var mealIndex: Int?
    var numShakes = 0
    
    let cellIdentifiers = ["Breakfast","Snack","Lunch","Snack","Dinner"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.currentDay = MealPlanStore.currentDay + 1
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Proxima Nova", size: 17)!]
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 79/255, green: 116/255, blue: 136/255, alpha: 1.0)
        navigationBar.title! = "Meal Map"
        
        
        // This allows for the side menu to appear from within the app
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        }
        
        let waterTrackerNib = UINib(nibName: "WaterTrackerTableViewCell", bundle: nil)
        tableView.register(waterTrackerNib, forCellReuseIdentifier: "WaterTrackerTableViewCell")
        tableView.tableFooterView = UIView()
        
        if RecipeStore.recipeSet.isEmpty {
            for day in MealPlanStore.currentMealPlan.days {
                if let dailyPlan = day as? DailyPlan {
                    for dailyMeal in dailyPlan.meals {
                        if let meal = dailyMeal as? Meal {
                            if let recipe = meal.recipe {
                                recipe.name = meal.recipe!.name
                                recipe.image = meal.recipe!.image
                                if RecipeStore.recipeSet.contains(recipe) == false {
                                    RecipeStore.recipeSet.insert(recipe)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Initialize the swipe left gesture to change days
        if (indexPath as NSIndexPath).row == 5{
            
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "WaterTrackerTableViewCell") as! WaterTrackerTableViewCell
            cell.selectionStyle = .none
            cell.amountDrank = (MealPlanStore.currentMealPlan.days[currentDay - 1] as AnyObject).amountDrank
            cell.currentDay = currentDay
            cell.updateProgress()
            return cell
            
        } else {
            // create a longPressRecognizer that is used for bringing up the modal to select recipes and marking the meal as eaten
            let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(MealMapTableViewController.longPress(_:)))
            self.view.addGestureRecognizer(longPressRecognizer)
            
            let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(MealMapTableViewController.nextDayButton(_:)))
            swipeLeft.direction = UISwipeGestureRecognizerDirection.left
            self.view.addGestureRecognizer(swipeLeft)
            
            // If the current day is 1 then allow the swipe right feature to bring out the side menu
            if currentDay == 1 {
                let panGestureRecognizer = self.revealViewController().panGestureRecognizer()
                self.view.addGestureRecognizer(panGestureRecognizer!)
                
            } else {
                // Remove the ability to open up the side menu by swiping when it is not the first day.
                self.view.removeGestureRecognizer(self.revealViewController().panGestureRecognizer())
                
                // Add the swipe right functionality to the view
                let swipeRight = UISwipeGestureRecognizer(target:self, action: #selector(MealMapTableViewController.previousDayButton(_:)))
                swipeRight.direction = UISwipeGestureRecognizerDirection.right
                self.view.addGestureRecognizer(swipeRight)
            }
            
            
            // Create a template cell as a MealMapTableViewCell
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for:indexPath) as! MealMapTableViewCell
            var mealName: String = "None"
            var image: UIImage?
            
            // Determine if the cell is to be a snack/shake or meal cell
            if cellIdentifiers[(indexPath as NSIndexPath).row] == "Snack" {
                if MealPlanStore.currentMealPlan.days.count > 0 {
                    if let day = MealPlanStore.currentMealPlan.days[currentDay-1] as? DailyPlan {
                        if let meal = day.meals[(indexPath as NSIndexPath).row] as? Meal {
                            image = meal.recipe!.image
                            mealName = meal.recipe!.name
                            //print("Meal Name \(mealName)")
                            if mealName.contains("Cleanse") {
                                print("Contained Cleanse")
                                self.numShakes += 1
                            }
                        }
                    }
                }
            } else if cellIdentifiers[(indexPath as NSIndexPath).row] != "DAY" {
                if MealPlanStore.currentMealPlan.days.count > 0 {
                    if let day = MealPlanStore.currentMealPlan.days[currentDay-1] as? DailyPlan {
                        image = (day.meals[(indexPath as NSIndexPath).row] as! Meal).recipe!.image
                        mealName = (day.meals[(indexPath as NSIndexPath).row] as! Meal).recipe!.name
                        //print("Meal Name \(mealName)")
                        if mealName.contains("Cleanse") {
                            //print("Contained Cleanse")
                            numShakes += 1
                        }
                    }
                }
            }
            cell.mealMapNameLabel.numberOfLines = 3
            cell.mealMapNameLabel.text = cellIdentifiers[(indexPath as NSIndexPath).row] + ":\n" + mealName
            cell.mealMapImageView.image = image
            cell.sizeToFit()
            
            return cell
        }
    }
    
    // Changes the current day to the next day in the meal plan
    @IBAction func nextDayButton(_ sender: UIBarButtonItem) {
        self.numShakes = 0
        // Check to see if the current day is less than the number of days in a meal plan
        if currentDay < numDaysInPlan {
            currentDay += 1
            
            // This will animate the movement of the table right to left
            let range = NSMakeRange(0, self.tableView.numberOfSections)
            let sections = IndexSet(integersIn: range.toRange() ?? 0..<0)
            self.tableView.reloadSections(sections, with: .left)
        }
    }
    
    // Changes the current day to the previous day
    @IBAction func previousDayButton(_ sender: UIBarButtonItem) {
        self.numShakes = 0
        // Check to see if the current day is greater than the first day in the meal plan
        if currentDay > 1 {
            currentDay -= 1
            // This will animate the movement of the table left to right
            let range = NSMakeRange(0, self.tableView.numberOfSections)
            let sections = IndexSet(integersIn: range.toRange() ?? 0..<0)
            self.tableView.reloadSections(sections, with: .right)
        }
    }
    
    // MARK: - Section Header Methods
    
    // Return the title of the section header. This will change based on the current
    //  day of the meal plan.
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
        navigationBar.title! = "Meal Map"
        return "Day " + String(currentDay)
    }
    
    // This configures and edits the section header
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        //recast your view as a UITableViewHeaderFooterView
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        //make the background color dark blue
        header.contentView.backgroundColor = UIColor(red: 18/255, green: 68/255, blue: 104/255, alpha: 1.0)
        header.textLabel!.textColor = UIColor.white //make the text white
        header.textLabel?.textAlignment = NSTextAlignment.center
        header.textLabel?.font
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath as NSIndexPath).row == 5 {
            return 170
        } else {
            return 81
        }
    }
    
    //Called, when long press occurred
    func longPress(_ longPressGestureRecognizer: UILongPressGestureRecognizer){
        
        if longPressGestureRecognizer.state == UIGestureRecognizerState.began {
            
            // Retrieve the touch point where the user pressed
            let touchPoint = longPressGestureRecognizer.location(in: self.view)
            
            // Get the index of the cell that the user clicked on and make sure it is not the water tracker
            if let indexPath = tableView.indexPathForRow(at: touchPoint) , (indexPath as NSIndexPath).row < 5 {
                // Alert Controller / Modal for selecting a new recipes
                let alertController = UIAlertController(title: "Edit Meal", message: "Select a new recipe?", preferredStyle: .actionSheet)
                
                // Cancel the Modal
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
                    action in
                    //print("Cancel pressed")
                })
                
                // Change the recipe
                let changeRecipeAction = UIAlertAction(title: "Change Recipe", style: .default, handler: {
                    action in
                    
                    self.mealIndex = (indexPath as NSIndexPath).row
                    if ((((MealPlanStore.currentMealPlan.days[self.currentDay - 1] as! DailyPlan).meals[(indexPath as NSIndexPath).row] as! Meal).recipe!.name.contains("Cleanse"))) {
                        if self.numShakes == (MealPlanStore.currentMealPlan.days[self.currentDay - 1] as! DailyPlan).minShakesForDay! {
                            // TODO: Need to implement a modal that says can't do less than the required minimum number of shakes
                        } else {
                            self.performSegue(withIdentifier: "selectRecipeModal", sender: self)
                        }
                    } else {
                        self.performSegue(withIdentifier: "selectRecipeModal", sender: self)
                    }
                })
                
                alertController.addAction(cancelAction)
                alertController.addAction(changeRecipeAction)
                
                alertController.popoverPresentationController?.sourceView = view
                present(alertController, animated: true, completion:nil)
            }
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        // Check to see if the segue that's happening is going to the detail view of the recipes
        if segue.identifier == "recipeDetailSegue" {
            
            // Figure out which row was just tapped
            if let row = (tableView.indexPathForSelectedRow as NSIndexPath?)?.row {
                // Get the item associated with this row and pass it along
                if MealPlanStore.currentMealPlan.days.count > 0 {
                    if let dailyPlan = MealPlanStore.currentMealPlan.days[currentDay-1] as? DailyPlan {
                        let meal = dailyPlan.meals[row]
                        let detailViewController = segue.destination as! MealDetailsTableViewController
                        detailViewController.meal = meal as! Meal
                    }
                }
            }
        } else if segue.identifier == "selectRecipeModal" {
            //print("Selecting new recipes\n")
            //print("Selected row [\(self.mealIndex)]")
            let selectNewRecipeController = segue.destination as! ChangeRecipeTableViewController
            selectNewRecipeController.dailyPlanIndex = currentDay - 1
            selectNewRecipeController.mealIndex = self.mealIndex!
            self.numShakes = 0
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    @IBAction func unwindToMealPlan(_ unwindSegue: UIStoryboardSegue) {
        
    }
}
