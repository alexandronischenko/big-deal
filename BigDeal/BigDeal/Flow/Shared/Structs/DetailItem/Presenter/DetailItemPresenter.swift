//
// Created by Alexandr Onischenko on 11.04.2022.
//

import Foundation

protocol DetailItemPresenterProtocol: AnyObject {
    init(coordinator: FlowCoordinatorProtocol, model: Item)
    func buttonPressedGoToShopSite(url: String)
    func didTapAddToFavorites(id: String, completion: (Bool) -> Void)
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
//        called in vc cause cant use this here
//        UIApplication.shared.open(url)
    }
    
    func didTapAddToFavorites(id: String, completion: (Bool) -> Void) {
        let array = DatabaseManager.shared.getAllFavorites()
        if array.contains(id) {
            DatabaseManager.shared.deleteFavoritesWith(id: id)
            completion(false)
        } else {
            DatabaseManager.shared.addToFavorites(id: id)
            completion(true)
        }
    }
}
