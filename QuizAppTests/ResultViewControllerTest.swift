//
//  ResultViewControllerTest.swift
//  QuizAppTests
//
//  Created by Eyüp Mert on 19.12.2023.
//

import XCTest
@testable import QuizApp

class ResultViewControllerTest: XCTestCase {
    
    func test_viewDidLoad_renderSummary() {
        let sut = ResultViewController(summary: "a Summary", answers: [])
        
        _ = sut.view
        
        XCTAssertEqual(sut.headerLabel.text, "a Summary")
    }
}
