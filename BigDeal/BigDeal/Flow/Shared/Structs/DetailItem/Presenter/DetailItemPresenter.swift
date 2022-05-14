//
// Created by Alexandr Onischenko on 11.04.2022.
//

import Foundation

protocol DetailItemPresenterProtocol: AnyObject {
    init(coordinator: FlowCoordinatorProtocol, model: Item)
    func buttonPressedGoToShopSite()
}

class DetailItemPresenter: DetailItemPresenterProtocol {
    var coordinator: FlowCoordinatorProtocol?
    weak var view: DetailItemViewProtocol?
    var model: Item?

    required init(coordinator: FlowCoordinatorProtocol, model: Item) {
        self.coordinator = coordinator
        self.model = model
        view?.configureModel(model: model)
    }

    func buttonPressedGoToShopSite() {
        coordinator?.moveTo(flow: .authProfile(.authentication(.login)))
    }
}
