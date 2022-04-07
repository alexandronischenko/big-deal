//
//  LoginBuilder.swift
//  BigDeal
//
//  Created by Alexandr Onischenko on 30.03.2022.
//

import Foundation
import UIKit

class AuthenticationLoginBuilder: ModuleBuilder {
    let coordinator: AuthenticationCoordinator
    init(coordinator: AuthenticationCoordinator) {
        self.coordinator = coordinator
    }
    
    func build() -> UIViewController {
        let presenter = AuthenticationLoginViewPresenter(coordinator: coordinator)
        let viewContoller = AuthenticationLoginScreenViewController(presenter: presenter)
        presenter.view = viewContoller
        return viewContoller
    }
}
