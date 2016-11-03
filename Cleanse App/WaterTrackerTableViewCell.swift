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
        self.amountToGo.text = "Consumed: \(self.amountDrank) oz"
        //self.goalAmount.text = "Goal: \(self.goal) Oz"
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func reset(){
        //progressView?.progress = 0.0
        self.amountToGo.text = "Consumed: 0 oz"
    }
    
    // MARK: - Increment Progress
    func updateProgress() {
        /*
        if amountDrank <= 0 {
            //progressView?.progress = 0
            self.amountDrank = 0
            self.amountToGo.text = "Consumed: \(self.amountDrank) oz"
            (MealPlanStore.currentMealPlan.days[currentDay - 1] as! DailyPlan).updateAmountDrank(0)
        }
        else if(amountDrank < goal){
            //progressView?.progress = Float(amountDrank) / Float(goal)
            
        } else {
            //progressView?.progress = 1
            self.amountDrank = goal
            (MealPlanStore.currentMealPlan.days[currentDay - 1] as! DailyPlan).updateAmountDrank(goal)
        }
        */
        if self.amountDrank > 300 {
            self.amountDrank = 300
        }
        self.amountToGo.text = "Consumed: \(self.amountDrank) oz"
        (MealPlanStore.currentMealPlan.days[currentDay - 1] as! DailyPlan).updateAmountDrank(self.amountDrank)
    }
    
    
    // MARK: - Buttons
    @IBAction func incrementByOne(_ sender: UIButton) {
        amountDrank += 1
        updateProgress()
    }
    @IBAction func decrementByOne(_ sender: UIButton) {
        amountDrank -= 1
        updateProgress()
    }
    @IBAction func add8Ounces(_ sender: UIButton) {
        amountDrank += 8
        updateProgress()
    }
    
    @IBAction func add16Ounces(_ sender: UIButton) {
        amountDrank += 16
        updateProgress()
    }
    @IBAction func add24Ounces(_ sender: UIButton) {
        amountDrank += 24
        updateProgress()
    }
    @IBAction func add32Ounces(_ sender: UIButton) {
        amountDrank += 32
        updateProgress()
    }
}
