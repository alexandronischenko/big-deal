import Foundation
import UIKit

class ProfileSubscriptionsModuleBuilder {
    static func buildModule(coordinator: ProfileBaseCoordinatorProtocol) -> UIViewController {
        let presenter = ProfileSubscriptionsPresenter(coordinator: coordinator)
        let viewController = ProfileSubscriptionsViewController(output: presenter)
        presenter.input = viewController
        return viewController
    }
}
