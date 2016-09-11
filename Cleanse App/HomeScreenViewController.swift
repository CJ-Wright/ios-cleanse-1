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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
