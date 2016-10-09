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
    var currentDay = 0
    
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
    
    func reset(){
        progressView?.progress = 0.0
        self.amountToGo.text = "You have 85 to go!"
    }
    
    // MARK: - Increment Progress
    func updateProgress() {
        if amountDrank <= 0 {
            progressView?.progress = 0
            self.amountDrank = 0
            self.amountToGo.text = "You have \(self.goal) to go!"
            (MealPlanStore.currentMealPlan.days[currentDay - 1] as! DailyPlan).updateAmountDrank(0)
        }
        else if(amountDrank < goal){
            progressView?.progress = Float(amountDrank) / Float(goal)
            self.amountToGo.text = "You have \(self.goal - self.amountDrank) to go!"
            (MealPlanStore.currentMealPlan.days[currentDay - 1] as! DailyPlan).updateAmountDrank(self.amountDrank)
        } else {
            progressView?.progress = 1
            self.amountToGo.text = "You 0 to go!"
            self.amountDrank = goal
            (MealPlanStore.currentMealPlan.days[currentDay - 1] as! DailyPlan).updateAmountDrank(goal)
        }
    }
    
    
    // MARK: - Buttons
    @IBAction func incrementByOne(sender: UIButton) {
        amountDrank += 1
        updateProgress()
    }
    @IBAction func decrementByOne(sender: UIButton) {
        amountDrank -= 1
        updateProgress()
    }
    @IBAction func add8Ounces(sender: UIButton) {
        amountDrank += 8
        updateProgress()
    }
    
    @IBAction func add16Ounces(sender: UIButton) {
        amountDrank += 16
        updateProgress()
    }
    @IBAction func add24Ounces(sender: UIButton) {
        amountDrank += 24
        updateProgress()
    }
    @IBAction func add32Ounces(sender: UIButton) {
        amountDrank += 32
        updateProgress()
    }
}
