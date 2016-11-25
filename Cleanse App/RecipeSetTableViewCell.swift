//
//  RecipeSetTableViewCell.swift
//  Cleanse App
//
//  Created by Erik Karlsson on 11/25/16.
//  Copyright © 2016 Nano Nimbus. All rights reserved.
//

import UIKit

class RecipeSetTableViewCell: UITableViewCell {

    @IBOutlet var recipeNameLabel: UILabel!
    @IBOutlet var recipeImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
