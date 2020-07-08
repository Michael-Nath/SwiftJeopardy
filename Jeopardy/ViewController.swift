//
//  ViewController.swift
//  Jeopardy
//
//  Created by Michael Nath on 7/6/20.
//  Copyright © 2020 Michael Nath. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBOutlet var categories: [UILabel]!
    let categoryOneQuestions = [
    "How many electrons are there in a Helium atom?",
    "It can't fly or breathe fire but this largest living lizard has a venomous bite that inhibits blood clotting",
    "It's the largest blood vessel in the body",
    "Of DNA's 8 bases this one was first discovered in animal dung hence its name",
    "Seems counterintuitive but the Earth is farthest from the sun during this month",
    ]
    let categoryOneAnswers = [
        "2",
        "Komodo Dragon",
        "Aorta",
        "Guanine",
        "July "
    ]
    //    do the same for every other category/answer
    var currentQuestion : JQuestion!
    @IBAction func questionPressed(_ sender: UIButton) {
        currentQuestion = JQuestion(
            question: categoryOneQuestions[sender.tag],
            answer: categoryOneAnswers[sender.tag],
            points: formattedPoints(sender.currentTitle!)
        )    
    }
    
    func formattedPoints(_ text : String) -> Int {
        var myStr = ""
        for char in text {
            if char != "$" {
                myStr += String(char)
            }
        }
        return Int(myStr) ?? 0
    }
    
}

