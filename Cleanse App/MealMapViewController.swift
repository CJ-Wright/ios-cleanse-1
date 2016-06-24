//
//  MealMapViewController.swift
//  Cleanse App
//
//  Created by Erik Karlsson on 6/2/16.
//  Copyright © 2016 Nano Nimbus. All rights reserved.
//

import UIKit

class MealMapViewController: UIViewController {
    
    @IBOutlet var menuButton: UIBarButtonItem!
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
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


    // MARK: Actions
    @IBAction func snackButton1(sender: UIButton) {
        
    }
    
    @IBAction func breakfastMealButton(sender: UIButton) {
    
    }
    
    @IBAction func snackButton2(sender: UIButton) {
    
    }
    
    @IBAction func lunchMealButton(sender: UIButton) {
    
    }
    
    @IBAction func snackButton3(sender: UIButton) {
    
    }
    
    @IBAction func dinnerMealButton(sender: UIButton) {
 
    }
}