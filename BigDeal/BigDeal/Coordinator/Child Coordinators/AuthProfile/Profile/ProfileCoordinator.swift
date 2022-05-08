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
        rootNavigationViewController.popToRootViewController(animated: true)
    }
    
    private func moveToProfileFlowSettingScreen() {
        let profileFlowSettingsViewController = ProfileSettingsModuleBuilder().buildModule(coordinator: self)
        rootNavigationViewController.pushViewController(profileFlowSettingsViewController, animated: true)
    }
    
    private func moveToProfileFlowSubscriptionsScreen() {
        let profileFlowSubscriptionsViewController = ProfileSubscriptionsModuleBuilder().buildModule(coordinator: self)
        rootNavigationViewController.pushViewController(profileFlowSubscriptionsViewController, animated: true)
    }
}

// MARK: - ProfileBaseCoordinatorProtocol

extension ProfileCoordinator: ProfileBaseCoordinatorProtocol {
    // Functions
    
    func start() -> UIViewController {
        let profileMainVC = ProfileMainModuleBuilder().buildModule(coordinator: self)
        rootViewController = profileMainVC
        return rootViewController
    }
    
    func moveTo(flow: AppFlow) {
        switch flow {
        case .authProfile(let appSubflow):
            switch appSubflow {
            case .profile(let profileScreen):
                moveToProfileFlow(with: profileScreen)
            case .authentication:
                parentCoordinator?.moveTo(flow: flow)
            }
        default :
            parentCoordinator?.moveTo(flow: flow)
        }
    }
}
