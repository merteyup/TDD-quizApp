//
//  QuestionViewControllerTest.swift
//  QuizAppTests
//
//  Created by Eyüp Mert on 19.12.2023.
//

import Foundation
import XCTest
@testable import QuizApp

class QuestionViewControllerTest: XCTestCase {
    
    func test_viewDidLoad_rendersQuestionHeaderText() {
        let sut = QuestionViewController(question: "Q1", options: [])
        
        _ = sut.view
        
        XCTAssertEqual(sut.headerLabel.text, "Q1")
    }
    
    func test_viewDidLoad_withNoOptionsRendersZeroOptions() {
        let sut = QuestionViewController(question: "Q1", options: [])

        _ = sut.view
        
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 0)
    }
    
    func test_viewDidLoad_withOneOptionsRendersOneOptions() {
        let sut = QuestionViewController(question: "Q1", options: ["A1"])

        _ = sut.view
        
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 1)
    }
    
    func test_viewDidLoad_withOneOptionsRendersOneOptionLabelText() {
        let sut = QuestionViewController(question: "Q1", options: ["A1"])

        _ = sut.view
        
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.tableView.dataSource?.tableView(sut.tableView, cellForRowAt: indexPath)
        
        XCTAssertEqual(cell?.textLabel?.text, "A1")
    }

}
