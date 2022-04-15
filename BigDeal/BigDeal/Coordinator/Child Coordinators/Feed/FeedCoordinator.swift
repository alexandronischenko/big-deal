import Foundation
import UIKit

class FeedCoordinator {
    // MARK: - Protocol properties
    
    var rootViewController = UIViewController()
    var parentCoordinator: MainBaseCoordinatorProtocol?
    
    // the bottom link is weak so that there is no cycle of strong links
    
    // MARK: - Private funcs
    
    private func moveToFeedFlow(with screen: FeedScreen) {
        switch screen {
        case .main:
            moveToFeedFlowMainScreen()
        }
    }
    
    private func moveToFeedFlowMainScreen() {
        navigationRootViewController?.popToRootViewController(animated: true)
    }
}

// MARK: - FeedBaseCoordinatorProtocol

extension FeedCoordinator: FeedBaseCoordinatorProtocol {
    // Functions
    
    func start() -> UIViewController {
        rootViewController = UINavigationController(rootViewController: FeedMainModuleBuilder().buildModule(coordinator: self))
        return rootViewController
    }
    
    func moveTo(flow: AppFlow) {
        switch flow {
        case .feed(let feedScreen):
            moveToFeedFlow(with: feedScreen)
        default:
            parentCoordinator?.moveTo(flow: flow)
        }
    }
}
