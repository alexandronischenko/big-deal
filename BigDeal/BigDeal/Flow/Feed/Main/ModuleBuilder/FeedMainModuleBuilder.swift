import Foundation
import UIKit

class FeedMainModuleBuilder {
    // MARK: - Properties
    
    var coordinator: FeedBaseCoordinatorProtocol
    
    // MARK: - Initializers
    
    init(coordinator: FeedBaseCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    // MARK: - Functions
    
    func buildModule() -> UIViewController {
        let remoteDataSource = HotRemoteDataSource()
        let localDataSource = HotLocalDataSource()
        let hotRepository = HotDataRepository(remoteDataSource: remoteDataSource, localDataSource: localDataSource)
        let presenter = FeedMainPresenter(coordinator: self.coordinator, hotRepository: hotRepository)
        let viewController = FeedMainViewController(output: presenter)
        presenter.input = viewController
        return viewController
    }
}
