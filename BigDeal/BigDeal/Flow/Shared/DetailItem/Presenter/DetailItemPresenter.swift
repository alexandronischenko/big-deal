//
// Created by Alexandr Onischenko on 11.04.2022.
//

import Foundation

protocol DetailItemPresenterProtocol: AnyObject {
    init(coordinator: AuthenticationCoordinator)
    func buttonPressedLetsGetStarted()
    func buttonPressedPrivacyPolicy()
}

class DetailItemPresenter: AuthenticationGreetingViewPresenterProtocol, BaseCoordinated {
    var coordinator: AuthenticationBaseCoordinatorProtocol?
    weak var view: AuthenticationGreetingViewProtocol?

    required init(coordinator: AuthenticationCoordinator) {
        self.coordinator = coordinator
    }

    func buttonPressedLetsGetStarted() {
        coordinator?.moveTo(flow: .authentication(.login))
    }

    func buttonPressedPrivacyPolicy() {
        // MARK: - TODO
    }
}
