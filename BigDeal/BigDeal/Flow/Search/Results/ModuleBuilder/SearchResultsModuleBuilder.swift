import Foundation
import UIKit

class SearchResultsModuleBuilder {
    func buildModule(coordinator: SearchBaseCoordinatorProtocol) -> UIViewController {
        let presenter = SearchResultsPresenter(coordinator: coordinator)
        let viewController = SearchResultsViewController(output: presenter)
        presenter.input = viewController
        return viewController
    }
}
