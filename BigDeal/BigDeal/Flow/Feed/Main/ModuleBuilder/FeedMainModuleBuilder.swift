import Foundation
import UIKit

class FeedMainModuleBuilder {
    static func buildModule(coordinator: FeedBaseCoordinatorProtocol) -> UIViewController {
        let presenter = FeedMainPresenter(coordinator: coordinator)
        let viewController = FeedMainViewController(output: presenter)
        presenter.input = viewController
        return viewController
    }
}
