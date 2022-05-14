import Foundation
import UIKit

class ProfileMainPresenter {
    // MARK: - Properties
    
    weak var input: ProfileMainPresenterInputProtocol?
    var coordinator: ProfileBaseCoordinatorProtocol?
    
    // MARK: - Initializers

    init(coordinator: ProfileBaseCoordinatorProtocol) {
        self.coordinator = coordinator
    }
}

// MARK: - ProfileBaseCoordinatedProtocol

extension ProfileMainPresenter: ProfileBaseCoordinatedProtocol {
}

// MARK: - ProfileMainPresenterOutputProtocol

extension ProfileMainPresenter: ProfileMainPresenterOutputProtocol {
    func moveToDetailFlow(model: Item) {
        coordinator?.moveTo(flow: .authProfile(.profile(.detail(model))))
    }
    
    func moveToSettingsScreen() {
        coordinator?.moveTo(flow: .authProfile(.profile(.settings)))
    }
    
    func moveToSubscriptionsScreen() {
        coordinator?.moveTo(flow: .authProfile(.profile(.subscriptions)))
    }
}
