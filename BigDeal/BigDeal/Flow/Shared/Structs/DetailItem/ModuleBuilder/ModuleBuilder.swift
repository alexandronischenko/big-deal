//
//  ModuleBuilder.swift
//  BigDeal
//
//  Created by Alexandr Onischenko on 09.04.2022.
//

import UIKit

class DetailItemBuilder {    
    let coordinator: DetailCoordinator
    init(coordinator: DetailCoordinator) {
        self.coordinator = coordinator
    }

    func build(model: Item) -> UIViewController {
        let presenter = DetailItemPresenter(coordinator: coordinator, model: model)
        let viewContoller = DetailItemViewController(presenter: presenter)
        presenter.view = viewContoller
        return viewContoller
    }
}
