//
//  AuthenticationLoginScreenViewController.swift
//  BigDeal
//
//  Created by Alexandr Onischenko on 28.03.2022.
//

import UIKit

class AuthenticationLoginScreenViewController: UIViewController {
    var presenter: AuthenticationLoginViewPresenterProtocol
    var loginView = AuthenticationLoginView()
    
    init(presenter: AuthenticationLoginViewPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.delegate = self
    }
}

extension AuthenticationLoginScreenViewController: AuthenticationLoginViewProtocol {
    func didPressedLogin(email: String, password: String) {
        presenter.didPressedLogin(email: email, password: password)
    }
    
    func didPressedRegister() {
        presenter.didPressedRegister()
    }
}
