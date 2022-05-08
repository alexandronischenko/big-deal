//
//  ModuleBuilder.swift
//  BigDeal
//
//  Created by Alexandr Onischenko on 09.04.2022.
//

import UIKit

class DetailItemBuilder: ModuleBuilder {
    func build() -> UIViewController {
    }
    
    let coordinator: FlowCoordinatorProtocol
    init(coordinator: FlowCoordinatorProtocol) {
        self.coordinator = coordinator
    }

    func build(model: Item) -> UIViewController {
        let presenter = AuthenticationGreetingViewPresenter(coordinator: coordinator, model: model)
        let viewContoller = AuthenticationGreetingViewController(presenter: presenter)
        presenter.view = viewContoller
        return viewContoller
    }
}
