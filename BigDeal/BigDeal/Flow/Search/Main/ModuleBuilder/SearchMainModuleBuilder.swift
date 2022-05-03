import Foundation
import UIKit

class SearchMainModuleBuilder {
    func buildModule(coordinator: SearchBaseCoordinatorProtocol) -> UIViewController {
        let presenter = SearchMainPresenter(coordinator: coordinator)
        let viewController = SearchMainViewController(output: presenter)
        presenter.input = viewController
        return viewController
    }
}
