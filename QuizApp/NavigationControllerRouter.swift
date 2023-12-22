//
//  NavigationControllerRouter.swift
//  QuizApp
//
//  Created by Eyüp Mert on 22.12.2023.
//

import UIKit
import QuizEngine

class NavigationControllerRouter: Router {
    private let navigationController: UINavigationController
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func routeTo(question: String, answerCallback: @escaping (String) -> Void) {
        navigationController.pushViewController(UIViewController(), animated: false)
    }

    func routeTo(result: Result<Question, Answer>) {
        
    }

}
