//
//  Question.swift
//  QuizApp
//
//  Created by Eyüp Mert on 22.12.2023.
//

import Foundation

enum Question<T: Hashable>: Hashable {
    case singleAnswer(T)
    case multipleAnswer(T)

    var hashValue: Int {
        switch self {
        case .singleAnswer(let t):
            return t.hashValue
        case .multipleAnswer(let t):
            return t.hashValue
        }
    }
    
    static func ==(lhs: Question<T>, rhs: Question<T>) -> Bool {
        switch (lhs, rhs) {
        case (.singleAnswer(let a), .singleAnswer(let b)):
            return a == b
        case(.multipleAnswer(let a), .multipleAnswer(let b)):
            return a == b
        default:
            return false
        }
    }
}
