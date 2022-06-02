import UIKit

class AuthenticationGreetingBuilder: ModuleBuilder {
    // MARK: - Property
    
    let coordinator: AuthenticationCoordinator
    // MARK: - Initializer
    
    init(coordinator: AuthenticationCoordinator) {
        self.coordinator = coordinator
    }
    // MARK: - Function
    
    func build() -> UIViewController {
        let presenter = AuthenticationGreetingViewPresenter(coordinator: coordinator)
        let viewContoller = AuthenticationGreetingViewController(presenter: presenter)
        presenter.view = viewContoller
        return viewContoller
    }
}
