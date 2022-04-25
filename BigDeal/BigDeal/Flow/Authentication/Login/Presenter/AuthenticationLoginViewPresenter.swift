//
//  LoginPresenter.swift
//  test
//
//  Created by Alexandr Onischenko on 29.03.2022.
//

import Foundation

protocol AuthenticationLoginViewPresenterProtocol: AnyObject {
    init(coordinator: AuthenticationCoordinator)
    func didPressedLogin()
    func didPressedRegister()
}

class AuthenticationLoginViewPresenter: AuthenticationLoginViewPresenterProtocol, AuthenticationBaseCoordinatedProtocol {
    weak var view: AuthenticationLoginViewProtocol?
    var coordinator: AuthenticationBaseCoordinatorProtocol?
    
    required init(coordinator: AuthenticationCoordinator) {
        self.coordinator = coordinator
    }
    
    func didPressedLogin() {
        // MARK: - TODO check data and login
//        coordinator?.moveTo(flow: .authentication(.greeting))
        coordinator?.moveTo(flow: .authProfile(.authentication(.greeting)))
    }
    
    func didPressedRegister() {
//        coordinator?.moveTo(flow: .authentication(.register))
        coordinator?.moveTo(flow: .authProfile(.authentication(.register)))
    }
}
