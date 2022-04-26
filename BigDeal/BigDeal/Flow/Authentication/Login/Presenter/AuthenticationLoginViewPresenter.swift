//
//  LoginPresenter.swift
//  test
//
//  Created by Alexandr Onischenko on 29.03.2022.
//

import Foundation
import FirebaseAuth

protocol AuthenticationLoginViewPresenterProtocol: AnyObject {
    init(coordinator: AuthenticationCoordinator)
    func didPressedLogin(email: String, password: String)
    func didPressedRegister()
}

class AuthenticationLoginViewPresenter: AuthenticationLoginViewPresenterProtocol, AuthenticationBaseCoordinatedProtocol {
    weak var view: AuthenticationLoginViewProtocol?
    var coordinator: AuthenticationBaseCoordinatorProtocol?
    
    required init(coordinator: AuthenticationCoordinator) {
        self.coordinator = coordinator
    }
    
    func didPressedLogin(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Error sign in \(error)")
                return
            } else {
                self.coordinator?.moveTo(flow: .authProfile(.authentication(.greeting)))
            }
        }
    }
    
    func didPressedRegister() {
        coordinator?.moveTo(flow: .authProfile(.authentication(.register)))
    }
}
