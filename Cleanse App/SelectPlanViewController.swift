//
//  SelectPlanViewController.swift
//  Cleanse App
//
//  Created by Erik Karlsson on 7/2/16.
//  Copyright © 2016 Nano Nimbus. All rights reserved.
//

import UIKit

class SelectPlanViewController: UIViewController {

    @IBOutlet var menuButton: UIBarButtonItem!
    @IBOutlet var detoxDescriptionTextView: UITextView!
    
    //  FFF0D5
//    var color = UIColor(red: 0xFF, green: 0xF0, blue: 0xD5, alpha: 1)
    // EFE4BD
//    var color = UIColor(red: 0xEF, green: 0xE4, blue: 0xBD, alpha: 1)
    
    var heavyMetalInformation = "The Fast Metabolism Heavy Metal Cleanse is for individuals looking for a program designed to help reduce: \n\n• Alcohol intolerance • Allergies (environmental / food sensitivities) • Anxiety and irritability • Brain fog • Inability to lose weight • Chronic unexplained pain • Coated tongue • Cold hands and feet • Dark circles under the eyes • Depression • Digestive problems • Extreme fatigue • Frequent colds and flus • Headaches • High levels of toxic metals in your blood, urine or tissues • Insomnia • Intolerance to medications & vitamins • Loss of memory and forgetfulness • Low body temperature • Metallic taste in mouth • Muscle and joint pain • Muscle tics or twitches • Muscle tremors • Night sweats • Prone to mood swings • Prone to rashes • Sensitive teeth • Sensitive to smells like tobacco smoke, perfumes, paint fumes and chemical odors • Skin problems • Small black spots on your gums • Sore or receding gums • Tingling in the extremities"
    
    var candidaInformation = "The Fast Metabolism Candida Cleanse is for individuals looking for a program designed to help reduce:\n\n• Skin and nail fungal infections, such as athlete’s foot or toenail fungus • Feeling tired and worn down, or suffering from chronic fatigue or fibromyalgia • Digestive issues such as bloating, constipation, diarrhea or chronic flatulence • Abdominal cramps alleviated by bowel movements • Irritable Bowel Syndrome ( Note: some have had amazing results with IBS after dealing with Candida / Yeast Issues ) • Heart burn / Indigestion • Dry mouth, bad breath • Autoimmune diseases such as Hashimoto’s thyroiditis, rheumatoid arthritis, ulcerative colitis, lupus, psoriasis, scleroderma, or multiple sclerosis • Difficulty concentrating, poor memory, lack of focus, ADD, ADHD, and brain fog • Skin issues (eczema, psoriasis, hives, and rashes) • Irritability, mood swings, anxiety, or depression • Vaginal infections, urinary tract infections, rectal itching, or vaginal itching • Severe seasonal allergies or itchy ears • Strong sugar and refined carbohydrate cravings • White coated tongue / Oral thrush • Food and chemical sensitivities • Eye fatigue, spots in front of eyes, burning or tearing eyes • Frequent ear infections, pressure, swelling or tingling of ears, itchy ears • Headaches • Dandruff, dry, itchy skin • Acne or other skin problems • Frequent urination • Frequent vaginal yeast infections, persistent vaginal  itching • Irregular menstruation, endometriosis, PMS • Poor libido"
    
    var parasiteInformation = "The Fast Metabolism Parasite Cleanse is for individuals looking for a program designed to help reduce:\n\n• Parasites • Symptoms of IBS • Traveler’s diarrhea • Skin irritations or unexplained rashes, hives, rosacea or eczema • Teeth grinding throughout the night • Pain or aching in your muscles or joints • Fatigue, exhaustion, depression, or frequent feelings of apathy • Iron-deficiency anemia \nIt also can help enhance performance, mental clarity, and stimulate detoxiﬁcation."
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    
    // MARK: - Buttons

    @IBAction func parasiteDetox(sender: UIButton) {
        let color = detoxDescriptionTextView.textColor
        detoxDescriptionTextView.text = parasiteInformation
        detoxDescriptionTextView.textColor = color
    }
    
    @IBAction func heavyMetalDetox(sender: UIButton) {
        let color = detoxDescriptionTextView.textColor
        detoxDescriptionTextView.text = heavyMetalInformation
        detoxDescriptionTextView.textColor = color
    }
    
    @IBAction func candidaDetox(sender: UIButton) {
        let color = detoxDescriptionTextView.textColor
        detoxDescriptionTextView.text = candidaInformation
        detoxDescriptionTextView.textColor = color
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
