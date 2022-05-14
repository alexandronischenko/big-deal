import Foundation
import UIKit

class AuthenticationLoginBuilder: ModuleBuilder {
    // MARK: - Properties
    let coordinator: AuthenticationCoordinator
    
    // MARK: - Initializers
    init(coordinator: AuthenticationCoordinator) {
        self.coordinator = coordinator
    }
    
    // MARK: - Functions
    func build() -> UIViewController {
        let presenter = AuthenticationLoginViewPresenter(coordinator: coordinator)
        let viewContoller = AuthenticationLoginScreenViewController(presenter: presenter)
        presenter.view = viewContoller
        return viewContoller
    }
}
