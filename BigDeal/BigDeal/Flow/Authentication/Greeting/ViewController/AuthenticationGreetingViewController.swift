//
//  AuthenticationGreetingScreenViewController.swift
//  BigDeal
//
//  Created by Renat Murtazin on 27.03.2022.
//

import UIKit

class AuthenticationGreetingViewController: UIViewController {
    var presenter: AuthenticationGreetingViewPresenterProtocol
    var greetingView = AuthenticationGreetingView()
    
    init(presenter: AuthenticationGreetingViewPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = greetingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        greetingView.delegate = self
    }
}

extension AuthenticationGreetingViewController: AuthenticationGreetingViewProtocol {
    func didPressedLetsGetStarted() {
        presenter.buttonPressedLetsGetStarted()
    }
}
