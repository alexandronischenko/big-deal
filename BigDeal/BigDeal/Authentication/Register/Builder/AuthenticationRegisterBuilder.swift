//
//  AuthenticationRegisterBuilder.swift
//  BigDeal
//
//  Created by Alexandr Onischenko on 06.04.2022.
//

import UIKit

class AuthenticationRegisterBuilder: ModuleBuilder {
    let coordinator: AuthenticationCoordinator
    init(coordinator: AuthenticationCoordinator) {
        self.coordinator = coordinator
    }
    
    func build() -> UIViewController {
        let presenter = AuthenticationRegisterViewPresenter(coordinator: coordinator)
        let viewContoller = AuthenticationRegisterViewController(presenter: presenter)
        presenter.view = viewContoller
        return viewContoller
    }
}
