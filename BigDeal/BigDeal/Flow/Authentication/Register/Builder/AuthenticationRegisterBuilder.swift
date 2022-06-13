import UIKit

class AuthenticationRegisterBuilder: ModuleBuilder {
    // MARK: - Properties
    
    let coordinator: AuthenticationCoordinator
    // MARK: - Initializers
    
    init(coordinator: AuthenticationCoordinator) {
        self.coordinator = coordinator
    }
    // MARK: - Functions
    
    func build() -> UIViewController {
        let presenter = AuthenticationRegisterViewPresenter(coordinator: coordinator)
        let viewContoller = AuthenticationRegisterViewController(presenter: presenter)
        presenter.view = viewContoller
        return viewContoller
    }
}
