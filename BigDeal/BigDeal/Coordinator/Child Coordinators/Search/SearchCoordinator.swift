import Foundation
import UIKit

class SearchCoordinator: SearchBaseCoordinator {
    
    var parentCoordinator: MainBaseCoordinator?
    
    var rootViewController: UIViewController = UIViewController()
    
    func start() -> UIViewController {
        rootViewController = UINavigationController(rootViewController: SearchMainScreenViewController(coordinator: self))
        return rootViewController
    }
    
    func moveTo(flow: AppFlow) {
        switch flow {
        case .search(let searchScreen):
            moveToSearchFlow(with: searchScreen)
        default:
            parentCoordinator?.moveTo(flow: flow)
        }
    }
    
    func moveToSearchFlow(with screen: SearchScreen) {
        switch screen {
        case .main:
            moveToSearchFlowMainScreen()
        case .detail:
            moveToSearchFlowDetailScreen()
        case .filter:
            moveToSearchFlowFilterScreen()
        }
    }
    
    func moveToSearchFlowMainScreen() {
        navigationRootViewController?.popToRootViewController(animated: true)
    }
    
    func moveToSearchFlowDetailScreen() {
        let searchFlowDetailViewController = DetailItemViewController()
        navigationRootViewController?.pushViewController(searchFlowDetailViewController, animated: true)
    }
    
    func moveToSearchFlowFilterScreen() {
        let searchFlowFilterViewController = SearchFilterScreenViewController()
        navigationRootViewController?.pushViewController(searchFlowFilterViewController, animated: true)
    }
}
