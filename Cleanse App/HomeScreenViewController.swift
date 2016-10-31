//
//  HomeScreenViewController.swift
//  Cleanse App
//
//  Created by Erik Karlsson on 7/10/16.
//  Copyright © 2016 Nano Nimbus. All rights reserved.
//

import UIKit

class HomeScreenViewController: UIViewController {

    @IBOutlet var menuButton: UIBarButtonItem!
    
    
    @IBOutlet var atAGlanceDesc: UILabel!
    @IBOutlet var detoxFactLabel: UILabel!
    @IBOutlet var tipOfTheDayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if MealPlanStore.currentDay < 0 || MealPlanStore.currentDay > 9 {
            MealPlanStore.resetPlanDay()
        }
        
        atAGlanceDesc.text = (MealPlanStore.currentMealPlan.days[9 - MealPlanStore.currentDay] as! DailyPlan).atAGlanceInstruction
        detoxFactLabel.text = (MealPlanStore.currentMealPlan.days[9 - MealPlanStore.currentDay] as! DailyPlan).detoxFacts
        tipOfTheDayLabel.text = (MealPlanStore.currentMealPlan.days[9 - MealPlanStore.currentDay] as! DailyPlan).tipOfTheDay
        
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Proxima Nova", size: 17)!]
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 79/255, green: 116/255, blue: 136/255, alpha: 1.0)

        // Do any additional setup after loading the view.
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
    
    func loadIntroStoryboard(){
        // Create a new storyboard instance
        let introStoryboard = UIStoryboard(name: "Introduction", bundle:  nil)
        
        // Create an instance of the storyboard's initial view controller
        let controller = introStoryboard.instantiateViewController(withIdentifier: "IntroductionStoryboard") as UIViewController
        
        // Display the new view controller
        controller.present(controller, animated: true, completion: nil)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
