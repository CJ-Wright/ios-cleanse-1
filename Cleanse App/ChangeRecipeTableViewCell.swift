//
//  ChangeRecipeTableViewCell.swift
//  Cleanse App
//
//  Created by Erik Karlsson on 9/15/16.
//  Copyright © 2016 Nano Nimbus. All rights reserved.
//

import UIKit

class ChangeRecipeTableViewCell: UITableViewCell {
    @IBOutlet var recipeNameLabel: UILabel!
    @IBOutlet var recipeImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
