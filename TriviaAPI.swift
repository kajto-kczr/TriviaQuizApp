//
//  TriviaAPI.swift
//  Trivia
//
//  Created by Nemrud Demir on 12.11.19.
//  Copyright © 2019 Kajetan Kuczorski. All rights reserved.
//

import Foundation

// MARK: - TriviaAPI
struct TriviaAPI: Codable {
    let responseCode: Int
    let results: [Result]

    enum CodingKeys: String, CodingKey {
        case responseCode = "response_code"
        case results
    }
}

// MARK: - Result
struct Result: Codable {
    let category: String
    let type: String
//    let difficulty: Difficulty
    let difficulty: String
    let question, correctAnswer: String
    let incorrectAnswers: [String]

    enum CodingKeys: String, CodingKey {
        case category, type, difficulty, question
        case correctAnswer = "correct_answer"
        case incorrectAnswers = "incorrect_answers"
    }
}
