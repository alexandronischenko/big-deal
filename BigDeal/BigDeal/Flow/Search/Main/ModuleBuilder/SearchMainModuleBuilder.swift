import Foundation
import UIKit

class SearchMainModuleBuilder {
    func buildModule(coordinator: SearchBaseCoordinatorProtocol) -> UIViewController {
        let remoteDataSource = ProductRemoteDataSource()
        let localDataSource = ProductLocalDataSource()
        let productRepository = ProductDataRepository(remoteDataSource: remoteDataSource, localDataSource: localDataSource)
        let presenter = SearchMainPresenter(coordinator: coordinator)
        let viewController = SearchMainViewController(output: presenter)
        presenter.input = viewController
        presenter.productRepository = productRepository
        return viewController
    }
}
