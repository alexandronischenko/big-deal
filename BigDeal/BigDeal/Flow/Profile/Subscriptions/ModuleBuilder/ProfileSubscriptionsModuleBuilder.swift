import Foundation
import UIKit

class ProfileSubscriptionsModuleBuilder {
    // MARK: - Properties
    
    var coordinator: ProfileBaseCoordinatorProtocol
    // MARK: - Initializers
    
    init(coordinator: ProfileBaseCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    // MARK: - Functions
    
    func buildModule() -> UIViewController {
        let presenter = ProfileSubscriptionsPresenter(coordinator: self.coordinator)
        let viewController = ProfileSubscriptionsViewController(output: presenter)
        presenter.input = viewController
        return viewController
    }
}
