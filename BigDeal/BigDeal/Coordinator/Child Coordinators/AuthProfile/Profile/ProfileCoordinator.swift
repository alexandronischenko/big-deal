import Foundation
import UIKit

class ProfileCoordinator {
    // MARK: - Protocol properties
    
    var rootNavigationViewController: UINavigationController
    var rootViewController = UIViewController()
    weak var parentCoordinator: AuthenticationProfileBaseCoordinatorProtocol?
    
    // the bottom link is weak so that there is no cycle of strong links
    
    // MARK: - Initializers
    
    init(rootNavigationViewController: UINavigationController) {
        self.rootNavigationViewController = rootNavigationViewController
    }
    // MARK: - Private functions
    
    private func moveToProfileFlow(with screen: ProfileScreen) {
        switch screen {
        case .main:
            moveToProfileFlowMainScreen()
        case .settings:
            moveToProfileFlowSettingScreen()
        case .subscriptions:
            moveToProfileFlowSubscriptionsScreen()
        case .detail(let model):
            moveToDetailScreen(model: model)
        }
    }
    
    private func moveToProfileFlowMainScreen() {
        rootNavigationViewController.popToRootViewController(animated: true)
    }
    
    private func moveToProfileFlowSettingScreen() {
        let profileFlowSettingsViewController = ProfileSettingsModuleBuilder(coordinator: self).buildModule()
        rootNavigationViewController.pushViewController(profileFlowSettingsViewController, animated: true)
    }
    
    private func moveToProfileFlowSubscriptionsScreen() {
        let profileFlowSubscriptionsViewController = ProfileSubscriptionsModuleBuilder(coordinator: self).buildModule()
        rootNavigationViewController.pushViewController(profileFlowSubscriptionsViewController, animated: true)
    }
    
    private func moveToDetailScreen(model: Item) {
        let detailViewController = DetailItemBuilder(coordinator: self).build(model: model)
        rootNavigationViewController.pushViewController(detailViewController, animated: true)
    }
}
// MARK: - ProfileBaseCoordinatorProtocol

extension ProfileCoordinator: ProfileBaseCoordinatorProtocol {
    // Functions
    
    func start() -> UIViewController {
        let profileMainVC = ProfileMainModuleBuilder(coordinator: self).buildModule()
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
