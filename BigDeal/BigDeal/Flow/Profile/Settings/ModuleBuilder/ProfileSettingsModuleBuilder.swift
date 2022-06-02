import Foundation
import UIKit

class ProfileSettingsModuleBuilder {
    // MARK: - Properties
    
    var coordinator: ProfileBaseCoordinatorProtocol
    // MARK: - Initializers
    
    init(coordinator: ProfileBaseCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    // MARK: - Functions
    
    func buildModule() -> UIViewController {
        let presenter = ProfileSettingsPresenter(coordinator: self.coordinator)
        let viewController = ProfileSettingsViewController(output: presenter)
        presenter.input = viewController
        return viewController
    }
}
