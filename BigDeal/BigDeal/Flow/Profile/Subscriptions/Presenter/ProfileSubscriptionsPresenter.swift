import Foundation

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
}

// MARK: - ProfileBaseCoordinatedProtocol

extension ProfileSubscriptionsPresenter: ProfileBaseCoordinatedProtocol {
}
