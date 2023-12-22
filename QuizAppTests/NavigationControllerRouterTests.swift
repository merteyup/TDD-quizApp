//
//  NavigationControllerRouterTests.swift
//  QuizAppTests
//
//  Created by Eyüp Mert on 22.12.2023.
//

import UIKit
import XCTest
import QuizEngine
@testable import QuizApp

class NavigationControllerRouterTests: XCTestCase {
    
    func test_routesToQuestion_presentsQuestionController() {
        let navigationController = UINavigationController()
        let factory = ViewControllerFactoryStub()
        let viewController = UIViewController()
        factory.stub(question: "Q1", with: viewController)
        
        let sut = NavigationControllerRouter(navigationController, factory: factory)
        
        sut.routeTo(question: "Q1", answerCallback: { _ in })

        XCTAssertEqual(navigationController.viewControllers.count, 1)
        XCTAssertEqual(navigationController.viewControllers.first, viewController)
    }
    
    func test_routesToSecondQuestion_presentsQuestionController() {
        let navigationController = UINavigationController()
        let factory = ViewControllerFactoryStub()
        let viewController = UIViewController()
        let secondViewController = UIViewController()
        factory.stub(question: "Q1", with: viewController)
        factory.stub(question: "Q2", with: secondViewController)

        let sut = NavigationControllerRouter(navigationController, factory: factory)

        sut.routeTo(question: "Q1", answerCallback: { _ in })
        sut.routeTo(question: "Q2", answerCallback: { _ in })
        
        XCTAssertEqual(navigationController.viewControllers.count, 2)
        XCTAssertEqual(navigationController.viewControllers.first, viewController)
        XCTAssertEqual(navigationController.viewControllers.last, secondViewController)
    }
    
    class ViewControllerFactoryStub: ViewControllerFactory {
        
        private var stubbedQuestions = [String: UIViewController]()
        
        func stub(question: String, with viewController: UIViewController) {
            stubbedQuestions[question] = viewController
        }
        
        func questionViewController(for question: String, answerCallback: (String) -> Void) -> UIViewController {
            return stubbedQuestions[question]!
        }
        
    }
    
}
