//
//  ViewController.swift
//  EnhanceQuizStarter
//
//  Created by Pasan Premaratne on 3/12/18.
//  Copyright © 2018 Treehouse. All rights reserved.
//  Edited by Phil Cachia on 25/04/2019

//  Treehouse Swift Tech Degree Project 02
//  Going for Exceeds Expectations mark
//  Please FAIL ME if this project does not Exceeds Expectations


// import frameworks
import UIKit
import GameKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    // setting the number of questions that will be picked up for each quiz game
    let questionsPerRound = 4
    // variable used to count the questions displayed
    var questionsAsked = 0
    // variable used to count correct questions
    var correctQuestions = 0
    // variable used to store the index of the randomly picked up question
    var indexOfSelectedQuestion = 0
    // array used to store the indexes of the previously picked up questions
    var pickedUpQuestions: [Int] = []
    
    
    var gameSoundStartGame: SystemSoundID = 0
    var gameSoundQuestionCorrect: SystemSoundID = 1
    var gameSoundQuestionWrong: SystemSoundID = 2

    // MARK: - Outlets
    
    // items (buttons & text) from main storyboard
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var answer1Button: UIButton!
    @IBOutlet weak var answer2Button: UIButton!
    @IBOutlet weak var answer3Button: UIButton!
    @IBOutlet weak var answer4Button: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    // items (switch & labels) for timer
    @IBOutlet weak var lightningModeSwitch: UISwitch!
    @IBOutlet weak var lightningModeLabel: UILabel!
    @IBOutlet weak var lightningModeTimerLabel: UILabel!
    
    // when the app starts, run the following functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadGameStartSound()
        loadGameQuestionCorrectSound()
        loadGameQuestionWrongSound()
        playGameStartSound()
        displayQuestion()
        runTimer()
    }
    
    // SOUNDS
    // <--
    // function to load start sound
    func loadGameStartSound() {
        let path = Bundle.main.path(forResource: "GameSound", ofType: "wav")
        let soundUrl = URL(fileURLWithPath: path!)
        AudioServicesCreateSystemSoundID(soundUrl as CFURL, &gameSoundStartGame)
    }
    
    // function to start sound when game starts
    func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSoundStartGame)
    }
    
    // function to load question correct sound
    func loadGameQuestionCorrectSound() {
        let path = Bundle.main.path(forResource: "Correct", ofType: "wav")
        let soundUrl = URL(fileURLWithPath: path!)
        AudioServicesCreateSystemSoundID(soundUrl as CFURL, &gameSoundQuestionCorrect)
    }

    // function to start sound when game starts
    func playQuestionCorrectSound() {
        AudioServicesPlaySystemSound(gameSoundQuestionCorrect)
    }

    // function to load question wrong sound
    func loadGameQuestionWrongSound() {
        let path = Bundle.main.path(forResource: "Wrong", ofType: "wav")
        let soundUrl = URL(fileURLWithPath: path!)
        AudioServicesCreateSystemSoundID(soundUrl as CFURL, &gameSoundQuestionWrong)
    }

    // function to start sound when game starts
    func playQuestionWrongSound() {
        AudioServicesPlaySystemSound(gameSoundQuestionWrong)
    }
    // -->

    // BUTTONS
    // <--
    // Enable the answer buttons
    func answerButtonsEnable() {
        answer1Button.isEnabled = true
        answer2Button.isEnabled = true
        answer3Button.isEnabled = true
        answer4Button.isEnabled = true
    }
    
    // Disable the answer buttons
    func answerButtonsDisable() {
        answer1Button.isEnabled = false
        answer2Button.isEnabled = false
        answer3Button.isEnabled = false
        answer4Button.isEnabled = false
    }
    
    // Hide the answer buttons
    func answerButtonsHide() {
        answer1Button.isHidden = true
        answer2Button.isHidden = true
        answer3Button.isHidden = true
        answer4Button.isHidden = true
    }
    
    // Show the answer buttons
    func answerButtonsShow() {
        answer1Button.isHidden = false
        answer2Button.isHidden = false
        answer3Button.isHidden = false
        answer4Button.isHidden = false
    }
    // -->

    // TIMER
    // timer credits - https://medium.com/ios-os-x-development/build-an-stopwatch-with-swift-3-0-c7040818a10f
    // <--
    //This variable will hold a starting value of seconds. It could be any amount above 0.
    var seconds = 15
    var timer = Timer()
    //This will be used to make sure only one timer is created at a time.
    var isTimerRunning = false
    //This will start the timer
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
    }    // -->
    @objc func updateTimer() {
        //This will decrement(count down)the seconds.
        seconds -= 1
        //This will update the label.
        lightningModeTimerLabel.text = "\(seconds)"
        // If timer reaches 0 seconds
        if seconds == 0 {
            // display to user that the answer is wrong
            questionField.text = "Sorry, time's up!"
            // play wrong sound
            playQuestionWrongSound()
            // disable answer buttons
            answerButtonsDisable()
            // stop timer
            timer.invalidate()
            // load next round after 2 seconds
            loadNextRound(delay: 2)
        }
    }
    @objc func resetTimer() {
        //This will reset the seconds.
        seconds = 15
        //This will update the label.
        lightningModeTimerLabel.text = "\(seconds)"
    }
    
    
    // sunction that display the question
    func displayQuestion() {
        // get index of randomly picked up question
        addToPickedUpQuestions()
        // get all question properties and store it into constant
        let questionDictionary = trivaQuestions[indexOfSelectedQuestion]
        // if answer button 4 is not applicable, hide button
        // else show button
        if questionDictionary.option4 == "N/A" {
            answer4Button.isHidden = true
        } else {
            answer4Button.isHidden = false
        }
        // set the question into the textfield
        questionField.text = questionDictionary.question
        // set the 4 different answers onto the 4 answer buttons
        answer1Button.setTitle(questionDictionary.option1, for: .normal)
        answer2Button.setTitle(questionDictionary.option2, for: .normal)
        answer3Button.setTitle(questionDictionary.option3, for: .normal)
        answer4Button.setTitle(questionDictionary.option4, for: .normal)
        // hide the play again button
        playAgainButton.isHidden = true
    }
    
    // function that triggers when the game ends
    func displayScore() {
        // hides the answer buttons when game ends
         answerButtonsHide()

        // Display play again button
        playAgainButton.isHidden = false
        
        // display results messege
        questionField.text = "Way to go!\nYou got \(correctQuestions) out of \(questionsPerRound) correct!"
    }
    
    // function to get a random question that is not picked up yet
    func addToPickedUpQuestions() {
        // get a random question
        indexOfSelectedQuestion = randomTrivaQuestion()
        // if the question has been alreally picked up, continue to pick up a question until it is not a dupblicate
        while pickedUpQuestions.contains(indexOfSelectedQuestion) {
            indexOfSelectedQuestion = randomTrivaQuestion()
        }
        // add picked up question index to the picked up index array
        pickedUpQuestions.append(indexOfSelectedQuestion)
    }

    // function to empty the array of picked up questions, triggers at the end of the game
    func emptyPickedUpQuestionsArray() {
        pickedUpQuestions.removeAll()
    }

    // function that get the game to the next round
    // if amount of questions asked has reached it's end, stop game
    // else load the next question
    func nextRound() {
        // Increment the questions asked counter
        questionsAsked += 1
       // Enable Buttons
        answerButtonsEnable()
        // set all answer buttons backgroundcolor to ivory
        answer1Button.backgroundColor = UIColor(red: 12.0/255.0, green: 121.0/255.0, blue: 150.0/255.0, alpha: 1.0)
        answer2Button.backgroundColor = UIColor(red: 12.0/255.0, green: 121.0/255.0, blue: 150.0/255.0, alpha: 1.0)
        answer3Button.backgroundColor = UIColor(red: 12.0/255.0, green: 121.0/255.0, blue: 150.0/255.0, alpha: 1.0)
        answer4Button.backgroundColor = UIColor(red: 12.0/255.0, green: 121.0/255.0, blue: 150.0/255.0, alpha: 1.0)
        if questionsAsked == questionsPerRound {
            // Game is over
            displayScore()
            // empty all randomly picked up questions from array
            emptyPickedUpQuestionsArray()
        } else {
            // reset time
            resetTimer()
            // Continue game
            displayQuestion()
            // run timer
            runTimer()
        }
    }
    
    // function that delays the start of next round by the amount of given seconds
    // triggers before loading the next question
    func loadNextRound(delay seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.nextRound()
        }
    }
    
    // MARK: - Actions
    
    // function that checks if the selected answer is correct
    // triggers when one of the four answer buttons is pressed
    @IBAction func checkAnswer(_ sender: UIButton) {
        // get selected question - question[randomlySelectedIndex]
        let selectedQuestionDict = trivaQuestions[indexOfSelectedQuestion]
        // correct answer for the picked up question
        let correctAnswer = selectedQuestionDict.correctAnswer
        // if the answer button pressed matches the question answer, the question is correct
        // else the question is wrong
        if (sender === answer1Button && correctAnswer == "1") || (sender === answer2Button && correctAnswer == "2") || (sender === answer3Button && correctAnswer == "3") || (sender === answer4Button && correctAnswer == "4") {
            // increment correct questions variable
            correctQuestions += 1
            // display to user that the answer is correct
            questionField.text = "Correct!"
            // change background color of correct answer button to green
            sender.backgroundColor = UIColor(red: 0/255.0, green: 255.0/255.0, blue: 0/255.0, alpha: 1.0)
            // play correct sound
            playQuestionCorrectSound()
        } else {
            // display to user that the answer is wrong
            questionField.text = "Sorry, wrong answer!"
            // change background color of wrong answer button to red
            sender.backgroundColor = UIColor(red: 255.0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)
            // color the button background color of the correct answer to green
            switch correctAnswer {
            case "1":
                answer1Button.backgroundColor = UIColor(red: 0/255.0, green: 255.0/255.0, blue: 0/255.0, alpha: 1.0)
            case "2":
                answer2Button.backgroundColor = UIColor(red: 0/255.0, green: 255.0/255.0, blue: 0/255.0, alpha: 1.0)
            case "3":
                answer3Button.backgroundColor = UIColor(red: 0/255.0, green: 255.0/255.0, blue: 0/255.0, alpha: 1.0)
            default:
                answer4Button.backgroundColor = UIColor(red: 0/255.0, green: 255.0/255.0, blue: 0/255.0, alpha: 1.0)
            }
            // play wrong sound
            playQuestionWrongSound()
        }
        // disable answer buttons
        answerButtonsDisable()
        // stop timer
        timer.invalidate()
        // load next round after 2 seconds
        loadNextRound(delay: 2)
    }
    
    // trigers when user wants to play again (clicks the play again button)
    @IBAction func playAgain(_ sender: UIButton) {
        // reset questions counter
        questionsAsked = -1
        // Show the answer buttons
        answerButtonsShow()
        // reset counters
        correctQuestions = 0
        // get first question
        nextRound()
        // play start game sound
        playGameStartSound()
    }
    
}

