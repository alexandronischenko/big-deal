//
//  AuthenticationRegisterViewPresenter.swift
//  BigDeal
//
//  Created by Alexandr Onischenko on 06.04.2022.
//

import Foundation
import UIKit

protocol AuthenticationRegisterViewPresenterProtocol: AnyObject {
    init(coordinator: AuthenticationCoordinator)
    func didPressedLogin()
    func didPressedRegister()
    func emailDidChange(textField: UITextField)
    func nameDidChange(textField: UITextField)
    func passwordDidChange(textField: UITextField)
}

class AuthenticationRegisterViewPresenter: AuthenticationRegisterViewPresenterProtocol, AuthenticationBaseCoordinatedProtocol {
    weak var view: AuthenticationRegisterViewProtocol?
    var coordinator: AuthenticationBaseCoordinatorProtocol?
    
    required init(coordinator: AuthenticationCoordinator) {
        self.coordinator = coordinator
    }
    
    func didPressedLogin() {
        // MARK: CHECK DATA
//        coordinator?.moveTo(flow: .profile(.main))
    }
    
    func didPressedRegister() {
        // MARK: CHECK DATA
        coordinator?.moveTo(flow: .profile(.main))
    }
        
    func emailDidChange(textField: UITextField) {
        guard let text = textField.text else { return }
        if !isValidEmail(text) {
            view?.showErrorLabel("Email is not valid. ")
            view?.changeTextFieldColor(textField)
        } else {
            view?.showErrorLabel("")
            view?.resetTextFieldColor(textField)
        }
    }
    
    func nameDidChange(textField: UITextField) {
        guard let text = textField.text else { return }
        if !isValidName(text) {
            view?.showErrorLabel("Name is not valid. ")
            view?.changeTextFieldColor(textField)
        } else {
            view?.showErrorLabel("")
            view?.resetTextFieldColor(textField)
        }
    }
    
    func passwordDidChange(textField: UITextField) {
        guard let text = textField.text else { return }
        if !isValidPassword(text) {
            view?.showErrorLabel("Password is not valid. ")
            view?.changeTextFieldColor(textField)
        } else {
            view?.showErrorLabel("")
            view?.resetTextFieldColor(textField)
        }
    }
    
    func isValidName(_ name: String) -> Bool {
        let usernamePattern = #"^[a-zA-Z0-9]([._-](?![._-])|[a-zA-Z0-9]){3,18}[a-zA-Z0-9]$"#
        
        let result = name.range(
            of: usernamePattern,
            options: .regularExpression
        )

        return (result != nil)
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailPattern = #"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"#
        
        let result = email.range(
            of: emailPattern,
            options: .regularExpression
        )

        return (result != nil)
    }
    
    func isValidPassword(_ password: String) -> Bool {
        //  Minimum eight characters, at least one letter and one number:
        let passwordPattern = #"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$"#
        
        let result = password.range(
            of: passwordPattern,
            options: .regularExpression
        )

        return (result != nil)
    }
}
