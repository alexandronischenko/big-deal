import Foundation
import UIKit

class ProfileMainModuleBuilder {
    // MARK: - Properties
    
    var coordinator: ProfileBaseCoordinatorProtocol
    
    // MARK: - Initializers
    
    init(coordinator: ProfileBaseCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    // MARK: - Functions
    
    func buildModule() -> UIViewController {
        let presenter = ProfileMainPresenter(coordinator: self.coordinator)
        let viewController = ProfileMainViewController(output: presenter)
        presenter.input = viewController
        presenter.repository = FavoritesRepository(remoteDataSource: FavoritesRemoteDataSource(), localDataSource: FavoritesLocalDataSource())
        return viewController
    }
}
