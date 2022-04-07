import Foundation
import UIKit

class ProfileMainModuleBuilder {
    func buildModule(coordinator: ProfileBaseCoordinatorProtocol) -> UIViewController {
        let presenter = ProfileMainPresenter(coordinator: coordinator)
        let viewController = ProfileMainViewController(output: presenter)
        presenter.input = viewController
        return viewController
    }
}
