//
// Created by Alexandr Onischenko on 11.04.2022.
//

import Foundation

protocol DetailItemPresenterProtocol: AnyObject {
    init(coordinator: FlowCoordinatorProtocol, model: Item)
    func buttonPressedGoToShopSite(url: String)
    func didTapAddToFavorites(url: String)
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

    func buttonPressedGoToShopSite(url: String) {
//        called in vc cause cant use this
//        UIApplication.shared.open(url)
    }
    
    func didTapAddToFavorites(url: String) {
        DatabaseManager.shared.addToFavorites(url: url)
    }
}
