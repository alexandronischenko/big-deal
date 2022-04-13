import Foundation
import UIKit

class SearchCoordinator {
    // MARK: - Protocol properties
    
    var rootViewController = UIViewController()
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
        case .results:
            moveToSearchFlowResultsScreen()
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
        let searchFlowFilterViewController = UINavigationController(rootViewController: SearchFilterModuleBuilder().buildModule(coordinator: self))
        searchFlowFilterViewController.modalPresentationStyle = .fullScreen
        searchFlowFilterViewController.navigationBar.prefersLargeTitles = false
        self.navigationRootViewController?.present(searchFlowFilterViewController, animated: true)
    }
    
    private func moveToSearchFlowResultsScreen() {
        let searchFlowResultsViewController = SearchResultsModuleBuilder().buildModule(coordinator: self)
        navigationRootViewController?.pushViewController(searchFlowResultsViewController, animated: true)
    }
}

// MARK: - SearchBaseCoordinatorProtocol

extension SearchCoordinator: SearchBaseCoordinatorProtocol {
    // Functions
    
    func start() -> UIViewController {
        rootViewController = UINavigationController(rootViewController: SearchResultsModuleBuilder().buildModule(coordinator: self))
        guard let navigationController = rootViewController as? UINavigationController else {
            return UIViewController()
        }
        navigationController.navigationBar.prefersLargeTitles = true
        return navigationController
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
