import Foundation

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
    
}

// MARK: - ProfileBaseCoordinatedProtocol

extension ProfileSettingsPresenter: ProfileBaseCoordinatedProtocol {
    
}
