import Foundation
import UIKit

class FeedCoordinator {
    
    // MARK: - Protocol properties
    
    var rootViewController: UIViewController = UIViewController()
    weak var parentCoordinator: MainBaseCoordinatorProtocol?
    
    // the bottom link is weak so that there is no cycle of strong links
    
    // MARK: - Private funcs
    
    private func moveToFeedFlow(with screen: FeedScreen) {
        switch screen {
        case .main:
            moveToFeedFlowMainScreen()
        case .detail:
            moveToFeedFlowDetailScreen()
        }
    }
    
    private func moveToFeedFlowMainScreen() {
        navigationRootViewController?.popToRootViewController(animated: true)
    }
    
    private func moveToFeedFlowDetailScreen() {
        let feedFlowDetailViewController = DetailItemViewController()
        navigationRootViewController?.pushViewController(feedFlowDetailViewController, animated: true)
    }
}

// MARK: - FeedBaseCoordinatorProtocol

extension FeedCoordinator: FeedBaseCoordinatorProtocol {
    
    // Funcs
    
    func start() -> UIViewController {
        rootViewController = UINavigationController(rootViewController: FeedMainModuleBuilder.buildModule(coordinator: self))
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
