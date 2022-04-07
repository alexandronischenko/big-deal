import Foundation
import UIKit

class ProfileSettingsModuleBuilder {
    static func buildModule(coordinator: ProfileBaseCoordinatorProtocol) -> UIViewController {
        let presenter = ProfileSettingsPresenter(coordinator: coordinator)
        let viewController = ProfileSettingsViewController(output: presenter)
        presenter.input = viewController
        return viewController
    }
}
