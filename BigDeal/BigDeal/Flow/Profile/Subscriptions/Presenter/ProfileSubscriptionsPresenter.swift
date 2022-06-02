import Foundation
import UIKit

class ProfileSubscriptionsPresenter {
    // MARK: - Properties
    
    weak var input: ProfileSubscriptionsPresenterInputProtocol?
    var coordinator: ProfileBaseCoordinatorProtocol?
    // MARK: - Initializers

    init(coordinator: ProfileBaseCoordinatorProtocol) {
        self.coordinator = coordinator
    }
}
// MARK: - ProfileSubscriptionsPresenterOutputProtocol

extension ProfileSubscriptionsPresenter: ProfileSubscriptionsPresenterOutputProtocol {
    func obtainDefaultButtonForBrandsCheckBoxController(_ brandsController: CheckBoxController) -> UIButton {
        guard let defaultButtonForBrands = brandsController.buttonsArray.first(where: { $0.currentTitle == "Adidas" }) else {
            return UIButton()
        }
        return defaultButtonForBrands
    }
    func obtainDefaultButtonForShopsCheckBoxController(_ shopsController: CheckBoxController) -> UIButton {
        guard let defaultButtonForShops = shopsController.buttonsArray.first(where: { $0.currentTitle == "Asos" }) else {
            return UIButton()
        }
        return defaultButtonForShops
    }
}
// MARK: - ProfileBaseCoordinatedProtocol

extension ProfileSubscriptionsPresenter: ProfileBaseCoordinatedProtocol {
}
