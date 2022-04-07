//
//  AuthenticationRegisterScreenViewController.swift
//  BigDeal
//
//  Created by Renat Murtazin on 27.03.2022.
//

import UIKit

class AuthenticationRegisterViewController: UIViewController {
    var presenter: AuthenticationRegisterViewPresenterProtocol
    var registerView = AuthenticationRegisterView()
    
    init(presenter: AuthenticationRegisterViewPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = registerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerView.delegate = self
    }
}

extension AuthenticationRegisterViewController: AuthenticationRegisterViewProtocol {
    func emailTextFieldDidChange(textField: UITextField) {
        presenter.emailDidChange(textField: textField)
    }
    
    func nameTextFieldDidChange(textField: UITextField) {
        presenter.nameDidChange(textField: textField)
    }
    
    func passwordTextFieldDidChange(textField: UITextField) {
        presenter.passwordDidChange(textField: textField)
    }
    
    func didPressedRegister() {
        presenter.didPressedRegister()
    }
    
    func didPressedLogin() {
        presenter.didPressedLogin()
    }
    
    func showErrorLabel(_ error: String) {
        registerView.showErrorLabel(text: error)
    }
    
    func changeTextFieldColor(_ sender: UITextField) {
        registerView.changeTextFieldColor(sender)
    }
    
    func resetTextFieldColor(_ sender: UITextField) {
        registerView.resetTextFieldColor(sender)
    }
}
