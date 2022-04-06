import Foundation
import UIKit

class ProfileCoordinator {
    
    // MARK: - Protocol properties
    
    var rootViewController: UIViewController = UIViewController()
    weak var parentCoordinator: MainBaseCoordinatorProtocol?
    
    // the bottom link is weak so that there is no cycle of strong links
    
    // MARK: - Private funcs
    
    private func moveToProfileFlow(with screen: ProfileScreen) {
        switch screen {
        case .main:
            moveToProfileFlowMainScreen()
        case .detail:
            moveToProfileFlowDetailScreen()
        case .settings:
            moveToProfileFlowSettingScreen()
        case .subscriptions:
            moveToProfileFlowSubscriptionsScreen()
        }
    }
    
    private func moveToProfileFlowMainScreen() {
        navigationRootViewController?.popToRootViewController(animated: true)
    }
    
    private func moveToProfileFlowDetailScreen() {
        let profileFlowDetailViewController = DetailItemViewController()
        navigationRootViewController?.pushViewController(profileFlowDetailViewController, animated: true)
    }
    
    private func moveToProfileFlowSettingScreen() {
        let profileFlowSettingsViewController = ProfileSettingsScreenViewController()
        navigationRootViewController?.pushViewController(profileFlowSettingsViewController, animated: true)
    }
    
    private func moveToProfileFlowSubscriptionsScreen() {
        let profileFlowSubscriptionsViewController = ProfileSubscriptionsModuleBuilder.buildModule(coordinator: self)
        navigationRootViewController?.pushViewController(profileFlowSubscriptionsViewController, animated: true)
    }
}

// MARK: - ProfileBaseCoordinatorProtocol

extension ProfileCoordinator: ProfileBaseCoordinatorProtocol {
    
    // Funcs
    
    func start() -> UIViewController {
        rootViewController = UINavigationController(rootViewController: ProfileMainScreenAssembly().assembledModule())
        return rootViewController
    }
    
    func moveTo(flow: AppFlow) {
        switch flow {
        case .profile(let profileScreen):
            moveToProfileFlow(with: profileScreen)
        default:
            parentCoordinator?.moveTo(flow: flow)
        }
    }
}
