//
//  ChangeRecipeTableViewController.swift
//  Cleanse App
//
//  Created by Erik Karlsson on 9/10/16.
//  Copyright © 2016 Nano Nimbus. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell, UITextFieldDelegate {

    // MARK: IBOutlet Properties
    
    @IBOutlet weak var textField: UITextField!
    
    
    // MARK: Constants
    
    let bigFont = UIFont(name: "Avenir-Book", size: 13.0)
    
    let smallFont = UIFont(name: "Avenir-Light", size: 12.0)
    
    let primaryColor = UIColor.black
    
    let secondaryColor = UIColor.lightGray
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        if textLabel != nil {
            textLabel?.font = bigFont
            textLabel?.textColor = primaryColor
        }
        
        if detailTextLabel != nil {
            detailTextLabel?.font = smallFont
            detailTextLabel?.textColor = secondaryColor
        }
        
        if textField != nil {
            textField.font = bigFont
            textField.delegate = self
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
