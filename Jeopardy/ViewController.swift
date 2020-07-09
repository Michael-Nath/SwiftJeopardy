//
//  ViewController.swift
//  Jeopardy
//
//  Created by Michael Nath on 7/6/20.
//  Copyright © 2020 Michael Nath. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var currentPoints = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        pointsDisplay.text = "Points : \(currentPoints)"
    }

    @IBOutlet var pointsDisplay: UILabel!
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var categories: [UILabel]!
//    Store all the questions and answers (2D Array in future)
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
        "July"
    ]
    //    do the same for every other category/answer
    var currentQuestion : JQuestion!
    var currentButton: UIButton!
    
//    handles the action of choosing a question
    @IBAction func questionPressed(_ sender: UIButton) {
        currentButton = sender
        currentQuestion = JQuestion(
            question: categoryOneQuestions[sender.tag],
            answer: categoryOneAnswers[sender.tag],
            points: formattedPoints(sender.currentTitle!)
        )
        showQuestion()

    }
    
//    gives a popup in which an user can answer the displayed question
    func showQuestion() {
        questionLabel.text = currentQuestion.question
        let alert = UIAlertController(title: "Answer", message: currentQuestion.question, preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Submit Answer", comment: "Default action"), style: .default, handler: { _ -> Void in
            self.verifyAnswer(alert.textFields![0].text)
        }))
        self.present(alert, animated:true, completion: nil)
    }
    
// verifies the proposed answer to the question
    func verifyAnswer(_ answer: String?) {
        if answer == currentQuestion.answer {
            questionLabel.text = "Correct!"
            currentPoints += currentQuestion.points
        } else {
            questionLabel.text = "Incorrect!"
        }
        updateUI()
    }
//    updates points (later will create new gameRound)
    func updateUI() {
        currentButton.isEnabled = false
//      alpha is like the opacity of the button
        currentButton.alpha = 0.5
        pointsDisplay.text = "Points : \(currentPoints)"
    }
//   makes the dollar-signed points easier to work with
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

