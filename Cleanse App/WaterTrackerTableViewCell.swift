//
//  WaterTrackerTableViewCell.swift
//  Cleanse App
//
//  Created by Erik Karlsson on 10/8/16.
//  Copyright © 2016 Nano Nimbus. All rights reserved.
//

import UIKit

class WaterTrackerTableViewCell: UITableViewCell {
    
    var amountDrank = 0
    var goal = 85
    
    @IBOutlet var amountToGo: UILabel!
    @IBOutlet var goalAmount: UILabel!
    
    @IBOutlet var progressView: UIProgressView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.amountToGo.text = "You have \(self.amountDrank) to go!"
        self.goalAmount.text = "Goal: \(self.goal) Oz"
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    // MARK: - Increment Progress
    func updateProgress() {
        
        progressView?.progress = Float(amountDrank) / Float(goal)
        print("MERP \(Float(amountDrank) / Float(goal))")
        
    }
    
    func updateToGoLabel(){
        self.amountToGo.text = "You have \(self.goal - self.amountDrank) to go!"
    }
    
    // MARK: - Buttons
    @IBAction func incrementByOne(sender: UIButton) {
        amountDrank += 1
        updateProgress()
        updateToGoLabel()
    }
    @IBAction func decrementByOne(sender: UIButton) {
        amountDrank -= 1
        updateProgress()
        updateToGoLabel()
    }
    @IBAction func add8Ounces(sender: UIButton) {
        amountDrank += 8
        updateProgress()
        updateToGoLabel()
    }
    
    @IBAction func add16Ounces(sender: UIButton) {
        amountDrank += 16
        updateProgress()
        updateToGoLabel()
    }
    @IBAction func add24Ounces(sender: UIButton) {
        amountDrank += 24
        updateProgress()
        updateToGoLabel()
    }
    @IBAction func add32Ounces(sender: UIButton) {
        amountDrank += 32
        updateProgress()
        updateToGoLabel()
    }
}
