//
//  MockAuthRegisterView.swift
//  BigDealTests
//
//  Created by Alexandr Onischenko on 07.04.2022.
//

import UIKit
@testable import BigDeal

class MockAuthRegisterView: AuthenticationRegisterViewProtocol {
    func showErrorLabel(_ error: String) {
    }
    
    func changeTextFieldColor(_ sender: UITextField) {
    }
    
    func resetTextFieldColor(_ sender: UITextField) {
    }
    
    func emailTextFieldDidChange(textField: UITextField) {
    }
    
    func nameTextFieldDidChange(textField: UITextField) {
    }
    
    func passwordTextFieldDidChange(textField: UITextField) {
    }
    
    func didPressedLogin() {
    }
    
    func didPressedRegister() {
    }
}
