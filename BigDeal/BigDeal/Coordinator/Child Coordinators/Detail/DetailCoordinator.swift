import Foundation
import UIKit

class DetailCoordinator {
    // MARK: - Protocol properties
    
    var rootViewController = UIViewController()
    var parentCoordinator: MainBaseCoordinatorProtocol?
    
    // the bottom link is weak so that there is no cycle of strong links
    
    // MARK: - Private funcs
    
    private func moveToDetailFlow(with screen: DetailScreen) {
        switch screen {
        case .main:
            moveToDetailFlowMainScreen()
        }
    }
    
    private func moveToDetailFlowMainScreen() {
        navigationRootViewController?.popToRootViewController(animated: true)
    }
}

extension DetailCoordinator: DetailBaseCoordinatorProtocol {
    // Functions
    
    func start() -> UIViewController {
        rootViewController = UINavigationController(rootViewController: DetailItemViewController())
        guard let navigationController = rootViewController as? UINavigationController else {
            return UIViewController()
        }
        navigationController.navigationBar.prefersLargeTitles = true
        return navigationController
    }
    
    func moveTo(flow: AppFlow) {
        switch flow {
        case .detail(let detailScreen):
            moveToDetailFlow(with: detailScreen)
        default:
            parentCoordinator?.moveTo(flow: flow)
        }
    }
}
