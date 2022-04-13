import Foundation
import UIKit

class SearchFilterModuleBuilder {
    func buildModule(coordinator: SearchBaseCoordinatorProtocol) -> UIViewController {
        let presenter = SearchFilterPresenter(coordinator: coordinator)
        let viewController = SearchFilterViewController(output: presenter)
        presenter.input = viewController
        return viewController
    }
}
