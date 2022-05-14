import Foundation
import UIKit

class FeedMainModuleBuilder {
    func buildModule(coordinator: FeedBaseCoordinatorProtocol) -> UIViewController {
        let remoteDataSource = HotRemoteDataSource()
        let localDataSource = HotLocalDataSource()
        let hotRepository = HotDataRepository(remoteDataSource: remoteDataSource, localDataSource: localDataSource)
        
        let presenter = FeedMainPresenter(coordinator: coordinator)
        let viewController = FeedMainViewController(output: presenter)
        presenter.input = viewController
        presenter.hotRepository = hotRepository
        return viewController
    }
}
