import Foundation
import UIKit

class ProfileCoordinator: ProfileBaseCoordinator {
    
    var parentCoordinator: MainBaseCoordinator?
    
    var rootViewController: UIViewController = UIViewController()
    
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
    
    func moveToProfileFlow(with screen: ProfileScreen) {
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
    
    func moveToProfileFlowMainScreen() {
        navigationRootViewController?.popToRootViewController(animated: true)
    }
    
    func moveToProfileFlowDetailScreen() {
        let profileFlowDetailViewController = DetailItemViewController()
        navigationRootViewController?.pushViewController(profileFlowDetailViewController, animated: true)
    }
    
    func moveToProfileFlowSettingScreen() {
        let profileFlowSettingsViewController = ProfileSettingsScreenViewController()
        navigationRootViewController?.pushViewController(profileFlowSettingsViewController, animated: true)
    }
    
    func moveToProfileFlowSubscriptionsScreen() {
        let profileFlowSubscriptionsViewController = ProfileSubscriptionsScreenViewController()
        navigationRootViewController?.pushViewController(profileFlowSubscriptionsViewController, animated: true)
    }
}
