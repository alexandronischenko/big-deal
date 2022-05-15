import Foundation
import UIKit

class AuthenticationProfileCoordinator {
    // MARK: - Protocol Properties
    
    var profileCoordinator: ProfileBaseCoordinatorProtocol?
    var authCoordinator: AuthenticationBaseCoordinatorProtocol?
    var rootViewController = UIViewController()
    var rootNavigationViewController: UINavigationController
    weak var parentCoordinator: MainBaseCoordinatorProtocol?
    
    // the bottom link is weak so that there is no cycle of strong links
    
    // MARK: - Initializers
    
    init(rootNavigationViewController: UINavigationController) {
        self.rootNavigationViewController = rootNavigationViewController
    }
    // MARK: - Private functions
    
    private func checkoutProfile(with flow: AppFlow) {
        if let profileCoordinator = profileCoordinator {
            profileCoordinator.moveTo(flow: flow)
        } else {
            rootNavigationViewController.viewControllers = []
            profileCoordinator = ProfileCoordinator(rootNavigationViewController: self.rootNavigationViewController)
            guard let profileVC = profileCoordinator?.start() else {
                return
            }
            profileCoordinator?.parentCoordinator = self
            rootNavigationViewController.pushViewController(profileVC, animated: true)
            rootNavigationViewController.navigationBar.prefersLargeTitles = true
            authCoordinator = nil
        }
    }
    
    private func checkoutAuth(with flow: AppFlow) {
        if let authCoordinator = authCoordinator {
            authCoordinator.moveTo(flow: flow)
        } else {
            rootNavigationViewController.viewControllers = []
            authCoordinator = AuthenticationCoordinator(rootNavigationViewController: self.rootNavigationViewController)
            guard let authVC = authCoordinator?.start() else {
                return
            }
            authCoordinator?.parentCoordinator = self
            rootNavigationViewController.pushViewController(authVC, animated: true)
            profileCoordinator = nil
        }
    }
}
// MARK: - AuthenticationProfileBaseCoordinatorProtocol

extension AuthenticationProfileCoordinator: AuthenticationProfileBaseCoordinatorProtocol {
    func start() -> UIViewController {
        let isLoggedIn = UserDefaults.standard.bool(forKey: UserDefaultsKeys.isLoggedInKey)
        if isLoggedIn {
            profileCoordinator = ProfileCoordinator(rootNavigationViewController: self.rootNavigationViewController)
            profileCoordinator?.parentCoordinator = self
            guard let profileVC = profileCoordinator?.start() else {
                return UIViewController()
            }
            rootNavigationViewController.pushViewController(profileVC, animated: true)
            rootNavigationViewController.navigationBar.prefersLargeTitles = true
            return rootNavigationViewController
        } else {
            authCoordinator = AuthenticationCoordinator(rootNavigationViewController: self.rootNavigationViewController)
            authCoordinator?.parentCoordinator = self
            guard let authVC = authCoordinator?.start() else {
                return UIViewController()
            }
            rootNavigationViewController.pushViewController(authVC, animated: true)
            return rootNavigationViewController
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
