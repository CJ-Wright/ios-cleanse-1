//
//  WaterTrackerViewController.swift
//  Cleanse App
//
//  Created by Erik Karlsson on 6/26/16.
//  Copyright © 2016 Nano Nimbus. All rights reserved.
//

import UIKit

class WaterTrackerViewController: UIViewController {

    @IBOutlet var menuButton: UIBarButtonItem!
    @IBOutlet var amountLabel: UILabel!
    var amountConsumed = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        amountLabel.text = String(amountConsumed) + " Ounces"
        // Do any additional setup after loading the view.
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
    

    @IBAction func addOuncesButton(sender: UIButton) {
        amountConsumed += 8
        amountLabel.text = String(amountConsumed) + " Ounces"
    }
    
    @IBAction func subtractOuncesButton(sender: UIButton) {
        amountConsumed -= 8
        amountLabel.text = String(amountConsumed) + " Ounces"
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
