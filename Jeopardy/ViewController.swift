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
    var questionBank: [String] = []
    var answerBank: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        pointsDisplay.text = "Points : \(currentPoints)"
        combineRounds()
        print(questionBank)
    }
    
    func combineRounds() {
        let qChoices = [categoryOneQuestions, categoryTwoQuestions, categoryThreeQuestions, categoryFourQuestions, categoryFiveQuestions, categorySixQuestions]
        let qAnswers = [categoryOneAnswers, categoryTwoAnswers, categoryThreeAnswers, categoryFourAnswers, categoryFiveAnswers, categorySixAnswers]
        for i in 0..<6 {
            let myQuestion = qChoices[i]
            let myAnswer = qAnswers[i]
            for j in 0..<myQuestion.count {
                questionBank.append(myQuestion[j])
                answerBank.append(myAnswer[j])
            }
        }
    }

    @IBOutlet var gameQuestions: [UIButton]!
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
    let categoryThreeQuestions = [
        "This university has 150000-plus students at its 4-year campuses which include Eau Claire & Oshkosh",
        "This California University is home to the Hoover Institution on War Revolution & Peace",
        "To stand out from other schools with George's name Washington University added in this Midwest city to its name",
        "What was the Norfolk division of the College of William & Mary took this venerable name",
        "The Red Stick International Digital Festival is an annual event at this university"
    ]
    let categoryThreeAnswers = [
        "The University of Wisconsin",
        "Stanford",
        "St. Louis",
        "Old Dominion",
        "LSU"
    ]
    
    let categoryTwoQuestions = [
        "Drop the from an H.G. Wells title to get the name of this 1952 novel narrated by a nameless young black man",
        "Published posthumously in 1870 Dickens' only true mystery novel was The Mystery of him",
        "James Dickey is best remembered for this novel about a harrowing canoe trip",
        "This Allen Ginsberg poem begins I saw the best minds of my generation destroyed by madness",
        "Elizabeth Strout won a 2009 Pulitzer Prize for her book of stories set in coastal Maine about this title woman"
    ]
    let categoryTwoAnswers = [
        "Invisible Man",
        "Edwin Drood",
        "Deliverance",
        "Howl",
        "Olive Kitteridge"
    ]
    let categoryFourQuestions = [
        "While men use foils epees & sabres in this Olympic event women use only foils",
        "The team that wins the Super Bowl is awarded the trophy named for him",
        "Baseball's Western League disbanded in 1900 & reformed as this league",
        "In 1938 Don Budge became the first player to achieve the Grand Slam in this sport",
        "He's the only boxer to have won the World Heavyweight Title three separate times"
    ]
    
    let categoryFourAnswers = [
        "Fencing",
        "The Vince Lombardi Trophy",
        "The American League",
        "Tennis",
        "Muhammed Ali"
    ]
    
    
    let categoryFiveQuestions = [
        "The ancient world had 2 important cities named Thebes: one in Greece & one in this land",
        "This '50s & '60s Soviet leader who told the West we will bury you is himself buried at Novodevichy Cemetery",
        "This national liberation front came to power in Nicaragua in 1979 & is ruling once again",
        "Around 1310 Pope Clement V moved the papacy from Italy to this French city & it stayed there for almost 70 years",
        "Around 200 B.C. an anonymous Chinese innovator froze rice milk & spices in a paste creating a type of this dessert"
    ]
    
    let categoryFiveAnswers = [
        "Egypt",
        "Khrushchev",
        "The Sandinistas",
        "Avignon",
        "Ice Cream"
    ]
    
    let categorySixQuestions = [
        "In 2018 he announced that his 3-year Farewell Yellow Brick Road tour would be his last",
        "This Chained To The Rhythm singer is a judge on the 2018 version of American Idol",
        "The song Remember Me from this animated film won an Oscar for Kristen Anderson-Lopez & Robert Lopez",
        "Their song Back In Black was a tribute to lead singer Bon Scott who had just died",
        "In a Khalid song about high school kids these 2 title adjectives follow Young"
    ]
    
    let categorySixAnswers = [
        "Elton John",
        "Katy Perry",
        "Coco",
        "AC/DC",
        "Dumb and Broke"
    ]
    var currentQuestion : JQuestion!
    var currentButton: UIButton!
    
//    handles the action of choosing a question
    @IBAction func questionPressed(_ sender: UIButton) {
        print(sender.superview!.tag)
        currentButton = sender
        currentQuestion = JQuestion(
            question: questionBank[(sender.superview!.tag) + (sender.tag * 5)],
            answer: answerBank[(sender.superview!.tag) + (sender.tag * 5)],
            points: formattedPoints(sender.currentTitle!)
        )
        showQuestion()

    }
    
//    gives a popup in which an user can answer the displayed question
    func showQuestion() {
        questionLabel.text = currentQuestion.question
        let alert = UIAlertController(title: "Question:", message: currentQuestion.question, preferredStyle: .alert)
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
            questionLabel.text = "Incorrect! Answer is '\(currentQuestion.answer)'"
        }
        updateUI()
    }
//    updates points (later will create new gameRound)
    func updateUI() {
        currentButton.isEnabled = false
//      alpha is like the opacity of the button
        currentButton.alpha = 0.5
        pointsDisplay.text = "Points : \(currentPoints)"
        if verifyNewRound() {
            questionLabel.text = "the game has just ended"
        }
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
    
    func verifyNewRound() -> Bool {
        for button in gameQuestions {
            if button.isEnabled {
                return false
            }
        }
        return true
    }
    
}

