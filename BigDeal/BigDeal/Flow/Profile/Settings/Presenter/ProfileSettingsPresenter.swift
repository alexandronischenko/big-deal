import Foundation
import UIKit

class ProfileSettingsPresenter {
    // MARK: - Properties
    
    weak var input: ProfileSettingsPresenterInputProtocol?
    var coordinator: ProfileBaseCoordinatorProtocol?
    // MARK: - Initializers

    init(coordinator: ProfileBaseCoordinatorProtocol) {
        self.coordinator = coordinator
    }
}
// MARK: - ProfileSubscriptionsPresenterOutputProtocol

extension ProfileSettingsPresenter: ProfileSettingsPresenterOutputProtocol {
    func obtainDefaultButtonForSexRadioController(_ sexRadioController: RadioButtonController) -> UIButton {
        guard let defaultButtonForSexCategory = sexRadioController.buttonsArray.first(where: { $0.currentTitle == "Male" }) else {
            return UIButton()
        }
        return defaultButtonForSexCategory
    }
}
// MARK: - ProfileBaseCoordinatedProtocol

extension ProfileSettingsPresenter: ProfileBaseCoordinatedProtocol {
}
