import Foundation
import UIKit

class SearchResultsModuleBuilder {
    // MARK: - Properties
    
    var coordinator: SearchBaseCoordinatorProtocol
    // MARK: - Initializers
    
    init(coordinator: SearchBaseCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    // MARK: - Functions
    
    func buildModule() -> UIViewController {
        let remoteDataSource = CategoryRemoteDataSource()
        let localDataSource = CategoryLocalDataSource()
        let categoriesRepository = CategoryDataRepository(remoteDataSource: remoteDataSource, localDataSource: localDataSource)
        let presenter = SearchResultsPresenter(coordinator: self.coordinator, categoryRepository: categoriesRepository)
        let viewController = SearchResultsViewController(output: presenter)
        presenter.input = viewController
        return viewController
    }
}
