//
//  AuthenticationGreetingBuilder.swift
//  BigDeal
//
//  Created by Alexandr Onischenko on 06.04.2022.
//

import UIKit

class AuthenticationGreetingBuilder: ModuleBuilder {
    let coordinator: AuthenticationCoordinator
    init(coordinator: AuthenticationCoordinator) {
        self.coordinator = coordinator
    }
    
    func build() -> UIViewController {
        let presenter = AuthenticationGreetingViewPresenter(coordinator: coordinator)
        let viewContoller = AuthenticationGreetingViewController(presenter: presenter)
        presenter.view = viewContoller
        return viewContoller
    }
}
