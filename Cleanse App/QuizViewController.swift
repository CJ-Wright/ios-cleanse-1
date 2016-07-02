//
//  QuizViewController.swift
//  Cleanse App
//
//  Created by Erik Karlsson on 7/2/16.
//  Copyright © 2016 Nano Nimbus. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    
    @IBOutlet var homeButton: UIBarButtonItem!
    @IBOutlet var question: UILabel!
    var isParasiteQuestion : Bool = false
    var isHeavyMetalQuestion : Bool = false
    var isCandidaQuestion : Bool = false
    
    var parasiteAnswer = [Bool]()
    var heavyMetalAnswer = [Bool]()
    var candidaAnswer = [Bool]()
    
    var askedParasiteQuestions = Set<Int>()
    var askedHeavyMetalQuestions = Set<Int>()
    var askedCandidaQuestions = Set<Int>()
    
    var questionSetAsked = Set<Int>()
    
    var questionIndex: Int = 0
    
    let parasiteQuestions: [String] = [
        "Have you had unexplained and sudden weight loss of at least 10 pounds over two months?",
        "Have you traveled internationally and remember getting traveler’s diarrhea or loose stool while abroad?",
        "Do you have skin irritations or unexplained rashes, hives, rosacea or eczema?",
        "Do you have cramping and abdominal pain?",
        "Have you recently had unexplained constipation, diarrhea, gas, or other symptoms of IBS?",
        "Do you have trouble sleeping or do you wake up throughout the night?",
        "Have you experienced food poisoning and your digestion has not been the same since?",
        "Do you have any pain or aching in your muscles or joints?",
        "Are you experiencing fatigue, exhaustion, depression, or frequent feelings of apathy?",
        "Do you never feel satisfied or full after your meals?"
    ]
    
    let heavyMetalQuestions: [String] = [
        "Do you have headaches, migraines or dizziness?",
        "Ave you been having chest pains or heart problems?",
        "Do you have dark circles under the eyes?",
        "Do you have an intolerance to medications and/or vitamins?",
        "Is your body temperature low?",
        "Do you have a metallic taste in your mouth?",
        "Have you had any muscle tics or twitches?",
        "Are your teeth sensitive?",
        "Are you sensitive to smells like tobacco smoke, perfumes, paint fumes and chemical odors?",
        "Do you have sore gums or have small black spots on your gums?"
    ]
    
    let candidaQuestions: [String] = [
        "Have you experienced slurred speech or a loss of muscle co-ordination or vision?",
        "Do you have any allergies to foods and/or airborne chemicals?",
        "Have you had athlete’s foot, hives, ringworm, jock itch or toenail fungus within the last month?",
        "Do you feel tired and worn down after eating?",
        "Do you have difficulty concentrating, poor memory, lack of focus, ADD, ADHD and/or brain fog?",
        "Had you had skin issues like eczema, psoriasis, hives and/or rashes?",
        "Have you been experiencing irritability, mood swings, anxiety or depression?",
        "Have you had vaginal infections, urinary tract infections, rectal itching or vaginal itching?",
        "Are you experiencing severe seasonal allergies or itchy ears?",
        "Do you have sugar and or carbohydrate cravings?"
    ]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        generateNewQuestion()
        
        if self.revealViewController() != nil {
            homeButton.target = self.revealViewController()
            homeButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    @IBAction func answerYes(Sender: AnyObject){
        print("Answered yes ")
        if(isParasiteQuestion)
        {
            print("to parasite question")
            parasiteAnswer.append(true)
        }
        else if(isHeavyMetalQuestion)
        {
            print("to heavy metal question")
            heavyMetalAnswer.append(true)
        }
        else{
            print("to candida question")
            candidaAnswer.append(true)
        }
        generateNewQuestion()
    }
    
    @IBAction func answerNo(Sender: AnyObject){
        print("Answered no ")
        if(isParasiteQuestion)
        {
            print("to parasite question")
            parasiteAnswer.append(false)
        }
        else if(isHeavyMetalQuestion)
        {
            print("to heavy metal question")
            heavyMetalAnswer.append(false)
        }
        else{
            print("to candida question")
            candidaAnswer.append(false)
        }
        generateNewQuestion()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func generateNewQuestion(){
        
        var randomNumber: Int
        randomNumber = Int(arc4random() % 3);
        
        while(questionSetAsked.contains(randomNumber) && questionSetAsked.count < 3)
        {
            randomNumber = Int(arc4random() % 3);
        }
        
        var randomQuestion = Int(arc4random() % 10);
        
        
        isParasiteQuestion = false
        isHeavyMetalQuestion = false
        isCandidaQuestion = false
        
        // Checks to see if all questions in the detox quiz have been asked
        if(questionIndex < 30)
        {
            
            switch(randomNumber)
            {
            case 0: // Random Question generated is a Parasite
                while(askedParasiteQuestions.contains(randomQuestion))
                {
                    randomQuestion = Int(arc4random() % 10);
                }
                
                askedParasiteQuestions.insert(randomQuestion)
                
                question.text = parasiteQuestions[randomQuestion]
                isParasiteQuestion = true
                
                if(askedParasiteQuestions.count >= 10)
                {
                    questionSetAsked.insert(randomNumber)
                }
                break;
            case 1: // Random Question generated is a Heavy Metal
                while(askedHeavyMetalQuestions.contains(randomQuestion))
                {
                    randomQuestion = Int(arc4random() % 10);
                }
                
                askedHeavyMetalQuestions.insert(randomQuestion)
                
                question.text = heavyMetalQuestions[randomQuestion]
                isHeavyMetalQuestion = true
                
                if(askedHeavyMetalQuestions.count >= 10)
                {
                    questionSetAsked.insert(randomNumber)
                }
                break;
            case 2: // Random Question generated is a Candida
                while(askedCandidaQuestions.contains(randomQuestion))
                {
                    randomQuestion = Int(arc4random() % 10);
                }
                
                askedCandidaQuestions.insert(randomQuestion)
                
                question.text = candidaQuestions[randomQuestion]
                isCandidaQuestion = true
                
                if(askedCandidaQuestions.count >= 10)
                {
                    questionSetAsked.insert(randomNumber)
                }
                break;
            default:
                break;
            }
            questionIndex += 1
            print(questionIndex)
        }
        else{
            question.text = "Finished answering all questions!"
        }
    }
    
    func determineDetox() -> String {
        var numCandidaTrue: Int = 0
        var numHeavyMetalTrue: Int = 0
        var numParasiteTrue: Int = 0
        
        for i in 0...9 {
            print("i is \(i)")
            if candidaAnswer[i] == true {
                numCandidaTrue += 1
            }
            if heavyMetalAnswer[i] == true {
                numHeavyMetalTrue += 1
            }
            if parasiteAnswer[i] == true {
                numParasiteTrue += 1
            }
        }
        if numCandidaTrue > numHeavyMetalTrue {
            if numCandidaTrue > numParasiteTrue {
                return "Follow candida detox"
            } else {
                return "Follow parasite detox"
            }
        } else if numHeavyMetalTrue > numParasiteTrue {
            return "Follow heavy metal detox"
        } else {
            return "Follow parasite detox"
        }
    }
}