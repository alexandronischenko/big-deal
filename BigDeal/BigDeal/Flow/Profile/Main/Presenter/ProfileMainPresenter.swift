import Foundation

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
}
