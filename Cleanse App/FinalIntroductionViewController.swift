//
//  FinalIntroductionViewController.swift
//  Cleanse App
//
//  Created by Erik Karlsson on 10/8/16.
//  Copyright © 2016 Nano Nimbus. All rights reserved.
//

import UIKit

class FinalIntroductionViewController: UIViewController {
    
    var messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    var initBegan = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func progressBarDisplayer(msg:String, _ indicator:Bool ) {
        print(msg)
        strLabel = UILabel(frame: CGRect(x: 50, y: 0, width: 300, height: 50))
        strLabel.text = msg
        strLabel.textColor = UIColor.whiteColor()
        messageFrame = UIView(frame: CGRect(x: view.frame.midX - 10, y: view.frame.midY - 25 , width: 280, height: 50))
        messageFrame.layer.cornerRadius = 15
        messageFrame.backgroundColor = UIColor(white: 0, alpha: 0.7)
        if indicator {
            activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.White)
            activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
            activityIndicator.startAnimating()
            messageFrame.addSubview(activityIndicator)
        }
        messageFrame.addSubview(strLabel)
        view.addSubview(messageFrame)
    }
    
    
    @IBAction func loadMainStoryboard(sender: UIButton) {
        
        if MealPlanStore.imagesFinishedDownloadSet.count > 0 {
            if initBegan == false{
                progressBarDisplayer("INITIALIZING MEAL PLAN", true)
                initBegan = true
            }
        }
        else {
            self.messageFrame.removeFromSuperview()
            // [1] Create a new "Storyboard2" instance.
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            // [2] Create an instance of the storyboard's initial view controller.
            let controller = storyboard.instantiateViewControllerWithIdentifier("InitialController") as UIViewController
            
            // [3] Display the new view controller.
            self.presentViewController(controller, animated: true, completion: nil)
            
            
        }
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
