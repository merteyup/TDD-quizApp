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
        XCTAssertEqual(makeSUT(question: "Q1").headerLabel.text, "Q1")
    }
    
    func test_viewDidLoad_rendersOptions() {
        XCTAssertEqual(makeSUT(question: "Q1").tableView.numberOfRows(inSection: 0), 0)
    }
    
    func test_viewDidLoad_withOneAndTwoOptionsRendersOneAndTwoOptions() {
        let sut = makeSUT(options: ["A1"])
        let sut2 = makeSUT(options: ["A1", "A2"])
        
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 1)
        XCTAssertEqual(sut2.tableView.numberOfRows(inSection: 0), 2)
    }
    
    func test_viewDidLoad_rendersOptionText() {
        let sut = makeSUT(options: ["A1", "A2"])
        let sut2 = makeSUT(options: ["A1", "A2"])

        XCTAssertEqual(sut.tableView.title(at: 0), "A1")
        XCTAssertEqual(sut2.tableView.title(at: 1), "A2")
    }
    
    func test_optionSelected_withSingleSelection_notifiesDelegateWithLastSelection() {
        var receivedAnswer = [String]()
        let sut = makeSUT(options: ["A1", "A2"]) { receivedAnswer = $0 }
        
        sut.tableView.select(row: 0)
        XCTAssertEqual(receivedAnswer, ["A1"])
        
        sut.tableView.select(row: 1)
        XCTAssertEqual(receivedAnswer, ["A2"])
    }
    
    func test_optionDeselected_withSingleSelection_doesNotNotifiesDelegateWithEmptySelection() {
        var callbackCount = 0
        
        let sut = makeSUT(options: ["A1", "A2"]) { _ in callbackCount += 1 }
        
        sut.tableView.select(row: 0)
        XCTAssertEqual(callbackCount, 1)

        sut.tableView.deselect(row: 0)
        XCTAssertEqual(callbackCount, 1)
    }
    
  func test_optionSelected_withMultipleSelectionEnabled_notifiesDelegateSelection() {
      var receivedAnswer = [String]()
      let sut = makeSUT(options: ["A1", "A2"]) { receivedAnswer = $0 }
      sut.tableView.allowsMultipleSelection = true
      
      sut.tableView.select(row: 0)
      XCTAssertEqual(receivedAnswer, ["A1"])
      
      sut.tableView.select(row: 1)
      XCTAssertEqual(receivedAnswer, ["A1", "A2"])
  }
    
    func test_optionDeselected_withMultipleSelectionEnabled_notifiesDelegateSelection() {
        var receivedAnswer = [String]()
        let sut = makeSUT(options: ["A1", "A2"]) { receivedAnswer = $0 }
        sut.tableView.allowsMultipleSelection = true
        
        sut.tableView.select(row: 0)
        XCTAssertEqual(receivedAnswer, ["A1"])
        
        sut.tableView.deselect(row: 0)
        XCTAssertEqual(receivedAnswer, [])
    }
    
    // MARK: - Helpers
    
    func makeSUT(question: String = "",
                 options: [String] = [],
                 selection: @escaping ([String]) -> Void = { _ in }) -> QuestionViewController {
        let sut = QuestionViewController(question: question, options: options, selection: selection)
        _ = sut.view
        return sut
    }

}

private extension UITableView {
    func cell(at row: Int) -> UITableViewCell? {
        return dataSource?.tableView(self, cellForRowAt: IndexPath(row: row, section: 0))
    }
    
    func title(at row: Int) -> String? {
        return cell(at: row)?.textLabel?.text
    }
    
    func select(row: Int) {
        let indexPath = IndexPath(row: row, section: 0)
        selectRow(at: indexPath, animated: false, scrollPosition: .none)
        delegate?.tableView?(self, didSelectRowAt: IndexPath(row: row, section: 0))
    }
    
    func deselect(row: Int) {
        let indexPath = IndexPath(row: row, section: 0)
        deselectRow(at: indexPath, animated: false)
        delegate?.tableView?(self, didDeselectRowAt: IndexPath(row: row, section: 0))
    }
}
