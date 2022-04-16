//
// Created by Alexandr Onischenko on 11.04.2022.
//

import Foundation

protocol DetailItemPresenterProtocol: AnyObject {
    init(coordinator: DetailCoordinator, model: Item)
    func buttonPressedGoToShopSite()
}

class DetailItemPresenter: DetailItemPresenterProtocol, DetailBaseCoordinatedProtocol {    
    var coordinator: DetailBaseCoordinatorProtocol?
    weak var view: DetailItemViewProtocol?
    var model: Item?

    required init(coordinator: DetailCoordinator, model: Item) {
        self.coordinator = coordinator
        self.model = model
        view?.configureModel(model: model)
    }

    func buttonPressedGoToShopSite() {


        coordinator?.moveTo(flow: .authentication(.login))
    }
}
