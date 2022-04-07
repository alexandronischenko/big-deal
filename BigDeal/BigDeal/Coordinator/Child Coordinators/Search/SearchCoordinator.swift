import Foundation
import UIKit

class SearchCoordinator {
    
    // MARK: - Protocol properties
    
    var rootViewController: UIViewController = UIViewController()
    var parentCoordinator: MainBaseCoordinatorProtocol?
    
    // the bottom link is weak so that there is no cycle of strong links
    
    // MARK: - Private funcs
    
    private func moveToSearchFlow(with screen: SearchScreen) {
        switch screen {
        case .main:
            moveToSearchFlowMainScreen()
        case .detail:
            moveToSearchFlowDetailScreen()
        case .filter:
            moveToSearchFlowFilterScreen()
        }
    }
    
    private func moveToSearchFlowMainScreen() {
        navigationRootViewController?.popToRootViewController(animated: true)
    }
    
    private func moveToSearchFlowDetailScreen() {
        let searchFlowDetailViewController = DetailItemViewController()
        navigationRootViewController?.pushViewController(searchFlowDetailViewController, animated: true)
    }
    
    private func moveToSearchFlowFilterScreen() {
        let searchFlowFilterViewController = SearchFilterScreenViewController()
        navigationRootViewController?.pushViewController(searchFlowFilterViewController, animated: true)
    }
}

// MARK: - SearchBaseCoordinatorProtocol

extension SearchCoordinator: SearchBaseCoordinatorProtocol {
    
    // Funcs
    
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
}
