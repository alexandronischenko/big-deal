import Foundation
// MARK: - AuthenticationGreetingViewPresenterProtocol

protocol AuthenticationGreetingViewPresenterProtocol: AnyObject {
    init(coordinator: AuthenticationCoordinator)
    func buttonPressedLetsGetStarted()
    func buttonPressedPrivacyPolicy()
}

class AuthenticationGreetingViewPresenter: AuthenticationBaseCoordinatedProtocol {
    // MARK: - Properties
    
    var coordinator: AuthenticationBaseCoordinatorProtocol?
    weak var view: AuthenticationGreetingViewProtocol?
    // MARK: - Initializers
    
    required init(coordinator: AuthenticationCoordinator) {
        self.coordinator = coordinator
    }
}
// MARK: - AuthenticationGreetingViewPresenterProtocol

extension AuthenticationGreetingViewPresenter: AuthenticationGreetingViewPresenterProtocol {
    func buttonPressedLetsGetStarted() {
        coordinator?.moveTo(flow: .authProfile(.authentication(.login)))
    }
    
    func buttonPressedPrivacyPolicy() {
        // MARK: - TODO
    }
}
