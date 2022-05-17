import Foundation
import UIKit

class SearchMainModuleBuilder {
    // MARK: - Properties
    
    var coordinator: SearchBaseCoordinatorProtocol
    // MARK: - Initializers
    
    init(coordinator: SearchBaseCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    // MARK: - Functions
    
    func buildModule() -> UIViewController {
        let remoteDataSource = ProductRemoteDataSource()
        let localDataSource = ProductLocalDataSource()
        let productRepository = ProductDataRepository(remoteDataSource: remoteDataSource, localDataSource: localDataSource)
        let presenter = SearchMainPresenter(coordinator: self.coordinator, productRepository: productRepository)
        let viewController = SearchMainViewController(output: presenter)
        presenter.input = viewController
        return viewController
    }
}
