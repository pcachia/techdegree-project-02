//
//  questionProvider.swift
//  EnhanceQuizStarter
//
//  Created by Phil Cachia on 4/21/19.
//  Copyright © 2019 Treehouse. All rights reserved.
//

// import frameworks
// basic apple framework for the app
import Foundation
// framework for picking up a random number
import GameKit

// QuestionProvider class, contains a question, 4 different answers and the correct answer that has to be chosen
class QuestionProvider {
    let question: String
    let option1: String
    let option2: String
    let option3: String
    let option4: String
    let correctAnswer: String

    init(question: String, option1: String, option2: String, option3: String, option4: String, correctAnswer: String) {
        self.question = question
        self.option1 = option1
        self.option2 = option2
        self.option3 = option3
        self.option4 = option4
        self.correctAnswer = correctAnswer
    }
}

// Questions - all following the class QuestionProvider
let question01 = QuestionProvider(
    question: "This was the only US President to serve more than two consecutive terms.",
    option1: "George Washington",
    option2: "Franklin D. Roosevelt",
    option3: "Woodrow Wilson",
    option4: "Andrew Jackson",
    correctAnswer: "2"
)

let question02 = QuestionProvider(
    question: "Which of the following countries has the most residents?",
    option1: "Nigeria",
    option2: "Russia",
    option3: "Iran",
    option4: "Vietnam",
    correctAnswer: "1"
)

let question03 = QuestionProvider(
    question: "In what year was the United Nations founded?",
    option1: "1918",
    option2: "1919",
    option3: "1945",
    option4: "1954",
    correctAnswer: "3"
)

let question04 = QuestionProvider(
    question: "The Titanic departed from the United Kingdom, where was it supposed to arrive?",
    option1: "Paris",
    option2: "Washington D.C.",
    option3: "New York City",
    option4: "Boston",
    correctAnswer: "3"
)

let question05 = QuestionProvider(
    question: "Which nation produces the most oil?",
    option1: "Iran",
    option2: "Iraq",
    option3: "Brazil",
    option4: "Canada",
    correctAnswer: "4"
)

let question06 = QuestionProvider(
    question: "Which country has most recently won consecutive World Cups in Soccer?",
    option1: "Italy",
    option2: "Brazil",
    option3: "Argetina",
    option4: "Spain",
    correctAnswer: "2"
)

let question07 = QuestionProvider(
    question: "Which of the following rivers is longest?",
    option1: "Yangtze",
    option2: "Mississippi",
    option3: "Congo",
    option4: "Mekong",
    correctAnswer: "2"
)

let question08 = QuestionProvider(
    question: "Which city is the oldest?",
    option1: "Mexico City",
    option2: "Cape Town",
    option3: "San Juan",
    option4: "Sydney",
    correctAnswer: "1"
)

let question09 = QuestionProvider(
    question: "Which country was the first to allow women to vote in national elections?",
    option1: "Poland",
    option2: "United States",
    option3: "Sweden",
    option4: "Senegal",
    correctAnswer: "1"
)

let question10 = QuestionProvider(
    question: "Which of these countries won the most medals in the 2012 Summer Games?",
    option1: "France",
    option2: "Germany",
    option3: "Japan",
    option4: "Great Britian ",
    correctAnswer: "4"
)

let question11 = QuestionProvider(
    question: "Which of these countries has the most population?",
    option1: "Russia",
    option2: "China",
    option3: "India",
    option4: "N/A",
    correctAnswer: "2"
)

let question12 = QuestionProvider(
    question: "Which of these countries has the largest area?",
    option1: "Russia",
    option2: "China",
    option3: "India",
    option4: "N/A",
    correctAnswer: "1"
)

let question13 = QuestionProvider(
    question: "Which of these countries is a part of the european continent?",
    option1: "Japan",
    option2: "China",
    option3: "France",
    option4: "N/A",
    correctAnswer: "3"
)

let question14 = QuestionProvider(
    question: "Which of these countries invented Pizza?",
    option1: "France",
    option2: "England",
    option3: "Italy",
    option4: "N/A",
    correctAnswer: "3"
)

let question15 = QuestionProvider(
    question: "Which of these countries grow jasmin rice?",
    option1: "Thailand",
    option2: "Italy",
    option3: "England",
    option4: "N/A",
    correctAnswer: "1"
)

// adding all existing questions to array
var trivaQuestions = [
    question01,
    question02,
    question03,
    question04,
    question05,
    question06,
    question07,
    question08,
    question09,
    question10,
    question11,
    question12,
    question13,
    question14,
    question15
]

// function to return a random question number
func randomTrivaQuestion() -> Int {
    let randomTrivaQuestionNumber = GKRandomSource.sharedRandom().nextInt(upperBound: trivaQuestions.count)
    return randomTrivaQuestionNumber
}

//trivaQuestions[randomTrivaQuestion()].question
