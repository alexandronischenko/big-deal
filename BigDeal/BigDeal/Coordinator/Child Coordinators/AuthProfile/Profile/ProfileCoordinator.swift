import Foundation
import UIKit

class ProfileCoordinator {
    // MARK: - Protocol properties
    
    var rootNavigationViewController: UINavigationController
    var rootViewController = UIViewController()
    weak var parentCoordinator: AuthenticationProfileBaseCoordinatorProtocol?
    
    // the bottom link is weak so that there is no cycle of strong links
    
    init(rootNavigationViewController: UINavigationController) {
        self.rootNavigationViewController = rootNavigationViewController
    }
    
    // MARK: - Private funcs
    
    private func moveToProfileFlow(with screen: ProfileScreen) {
        switch screen {
        case .main:
            moveToProfileFlowMainScreen()
        case .settings:
            moveToProfileFlowSettingScreen()
        case .subscriptions:
            moveToProfileFlowSubscriptionsScreen()
        }
    }
    
    private func moveToProfileFlowMainScreen() {
        navigationRootViewController?.popToRootViewController(animated: true)
    }
    
    private func moveToProfileFlowSettingScreen() {
        let profileFlowSettingsViewController = ProfileSettingsModuleBuilder().buildModule(coordinator: self)
        navigationRootViewController?.pushViewController(profileFlowSettingsViewController, animated: true)
    }
    
    private func moveToProfileFlowSubscriptionsScreen() {
        let profileFlowSubscriptionsViewController = ProfileSubscriptionsModuleBuilder().buildModule(coordinator: self)
        navigationRootViewController?.pushViewController(profileFlowSubscriptionsViewController, animated: true)
    }
}

// MARK: - ProfileBaseCoordinatorProtocol

extension ProfileCoordinator: ProfileBaseCoordinatorProtocol {
    // Functions
    
    func start() -> UIViewController {
        rootViewController = UINavigationController(rootViewController: ProfileMainModuleBuilder().buildModule(coordinator: self))
        guard let navigationController = rootViewController as? UINavigationController else {
            return UIViewController()
        }
        navigationController.navigationBar.prefersLargeTitles = true
        return navigationController
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
