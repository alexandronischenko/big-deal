import Foundation
import UIKit

class FeedCoordinator: FeedBaseCoordinator {
    
    var parentCoordinator: MainBaseCoordinator?
    
    var rootViewController: UIViewController = UIViewController()
    
    func start() -> UIViewController {
        rootViewController = UINavigationController(rootViewController: FeedMainScreenViewController(coordinator: self))
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
    
    func moveToFeedFlow(with screen: FeedScreen) {
        switch screen {
        case .main:
            moveToFeedFlowMainScreen()
        case .detail:
            moveToFeedFlowDetailScreen()
        }
    }
    
    func moveToFeedFlowMainScreen() {
        navigationRootViewController?.popToRootViewController(animated: true)
    }
    
    func moveToFeedFlowDetailScreen() {
        let feedFlowDetailViewController = DetailItemViewController()
        navigationRootViewController?.pushViewController(feedFlowDetailViewController, animated: true)
    }
}
