import Foundation
import UIKit

class AuthenticationProfileCoordinator {
    // MARK: - Properties
    
    var profileCoordinator: ProfileBaseCoordinatorProtocol?
    var authCoordinator: AuthenticationBaseCoordinatorProtocol?
    var rootViewController = UIViewController()
    var rootNavigationViewController = UINavigationController()
    weak var parentCoordinator: MainBaseCoordinatorProtocol?
    
    private func checkoutProfile(with flow: AppFlow) {
        if let profileCoordinator = profileCoordinator {
            profileCoordinator.moveTo(flow: flow)
        } else {
            profileCoordinator = ProfileCoordinator(rootNavigationViewController: self.rootNavigationViewController)
            guard let controller = profileCoordinator?.start() else {
                return
            }
            profileCoordinator?.parentCoordinator = self
            rootNavigationViewController.pushViewController(controller, animated: true)
            rootNavigationViewController.viewControllers = []
            authCoordinator = nil
        }
    }
    
    private func checkoutAuth(with flow: AppFlow) {
        if let authCoordinator = authCoordinator {
            authCoordinator.moveTo(flow: flow)
        } else {
            authCoordinator = AuthenticationCoordinator(rootNavigationViewController: self.rootNavigationViewController)
            guard let controller = authCoordinator?.start() else {
                return
            }
            authCoordinator?.parentCoordinator = self
            rootNavigationViewController.pushViewController(controller, animated: true)
            rootNavigationViewController.viewControllers = []
            profileCoordinator = nil
        }
    }
}

extension AuthenticationProfileCoordinator: AuthenticationProfileBaseCoordinatorProtocol {
    func start() -> UIViewController {
        let isLoggedIn = UserDefaults.standard.bool(forKey: UserDefaultsKeys.isLoggeInKey)
        if isLoggedIn {
            profileCoordinator = ProfileCoordinator(rootNavigationViewController: self.rootNavigationViewController)
            profileCoordinator?.parentCoordinator = self
            guard let profileVC = profileCoordinator?.start() else {
                return UIViewController()
            }
            navigationRootViewController?.pushViewController(profileVC, animated: true)
            return profileVC
        } else {
            authCoordinator = AuthenticationCoordinator(rootNavigationViewController: self.rootNavigationViewController)
            authCoordinator?.parentCoordinator = self
            guard let authVC = authCoordinator?.start() else {
                return UIViewController()
            }
            navigationRootViewController?.pushViewController(authVC, animated: true)
            return authVC
        }
    }
    
    func moveTo(flow: AppFlow) {
        switch flow {
        case .authProfile(let appSubflow):
            switch appSubflow {
            case .profile:
                checkoutProfile(with: flow)
            case .authentication:
                checkoutAuth(with: flow)
            }
        default:
            parentCoordinator?.moveTo(flow: flow)
        }
    }
}
