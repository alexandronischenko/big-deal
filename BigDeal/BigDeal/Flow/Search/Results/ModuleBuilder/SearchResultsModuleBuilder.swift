import Foundation
import UIKit

class SearchResultsModuleBuilder {
    func buildModule(coordinator: SearchBaseCoordinatorProtocol) -> UIViewController {
        let remoteDataSource = CategoryRemoteDataSource()
        let localDataSource = CategoryLocalDataSource()
        let categoriesRepository = CategoryDataRepository(remoteDataSource: remoteDataSource, localDataSource: localDataSource)
        let presenter = SearchResultsPresenter(coordinator: coordinator)
        let viewController = SearchResultsViewController(output: presenter)
        presenter.input = viewController
        presenter.categoryRepository = categoriesRepository
        return viewController
    }
}
