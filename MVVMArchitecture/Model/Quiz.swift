//
//  Quiz.swift
//  Learn Java Programming
//
//  Created by TL-1 on 08/02/23.
//

import Foundation

class Quiz{
    var question: String
    var optionA: String
    var optionB: String
    var optionC: String
    var optionD: String
    var answer: String
    
    init(question: String, optionA: String, optionB: String, optionC: String, optionD: String, answer: String) {
        self.question = question
        self.optionA = optionA
        self.optionB = optionB
        self.optionC = optionC
        self.optionD = optionD
        self.answer = answer
    }
}
