//
//  AuthenticationGreetingViewController.swift
//  BigDeal
//
//  Created by Alexandr Onischenko on 06.04.2022.
//

import Foundation

protocol AuthenticationGreetingViewPresenterProtocol: AnyObject {
    init(coordinator: AuthenticationCoordinator)
    func buttonPressedLetsGetStarted()
    func buttonPressedPrivacyPolicy()
}

class AuthenticationGreetingViewPresenter: AuthenticationGreetingViewPresenterProtocol, AuthenticationBaseCoordinatedProtocol {
    var coordinator: AuthenticationBaseCoordinatorProtocol?
    weak var view: AuthenticationGreetingViewProtocol?
    
    required init(coordinator: AuthenticationCoordinator) {
        self.coordinator = coordinator
    }
    
    func buttonPressedLetsGetStarted() {
        coordinator?.moveTo(flow: .authProfile(.authentication(.login)))
    }
    
    func buttonPressedPrivacyPolicy() {
        // MARK: - TODO
    }
}
