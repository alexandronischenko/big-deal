//
//  AuthenticationRegisterViewPresenter.swift
//  BigDeal
//
//  Created by Alexandr Onischenko on 06.04.2022.
//

import Foundation
import UIKit
import FirebaseAuth

protocol AuthenticationRegisterViewPresenterProtocol: AnyObject {
    init(coordinator: AuthenticationCoordinator)
    func didPressedLogin()
    func didPressedRegister(email: String, name: String, password: String)
    func emailDidChange(textField: UITextField)
    func nameDidChange(textField: UITextField)
    func passwordDidChange(textField: UITextField)
}

class AuthenticationRegisterViewPresenter: AuthenticationBaseCoordinatedProtocol, AuthenticationRegisterViewPresenterProtocol {
    weak var view: AuthenticationRegisterViewProtocol?
    var coordinator: AuthenticationBaseCoordinatorProtocol?
    
    required init(coordinator: AuthenticationCoordinator) {
        self.coordinator = coordinator
    }
    
    func didPressedLogin() {
        coordinator?.moveTo(flow: .authProfile(.authentication(.login)))
    }
    
    func didPressedRegister(email: String, name: String, password: String) {
        if !(isValidEmail(email) && isValidName(name) && isValidPassword(password)) {
            view?.showErrorLabel("Data is not valid")
            return
        }
        
        DatabaseManager.shared.userExists(withEmail: email) { [weak self] exists in
            guard !exists else {
                self?.view?.showErrorLabel("User with that email adress already exists ")
                return
            }
            
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    print("Error creating user: \(error)")
                    return
                }
                
                print("Auth result: \(String(describing: authResult))")
                
                let userModel = UserModel(name: name, emailAdress: email, profilePicture: "")
                
                DatabaseManager.shared.insertUser(with: userModel)
                UserDefaults.standard.set(true, forKey: UserDefaultsKeys.isLoggedInKey)
                UserDefaults.standard.set(userModel.safeEmail, forKey: UserDefaultsKeys.safeEmailKey)
                
                self?.coordinator?.moveTo(flow: .authProfile(.profile(.main)))
            }
        }
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
        let usernamePattern = #"^[a-zA-Z0-9]{3,18}$"#
        
        let result = name.range(
            of: usernamePattern,
            options: .regularExpression
        )
        
        return (result != nil)
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailPattern = #"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+[.][A-Za-z]{2,64}"#
        
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
