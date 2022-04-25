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
            _ = profileCoordinator?.start()
            profileCoordinator?.parentCoordinator = self
            rootNavigationViewController.viewControllers = []
            authCoordinator = nil
        }
    }
    
    private func checkoutAuth(with flow: AppFlow) {
        if let authCoordinator = authCoordinator {
            authCoordinator.moveTo(flow: flow)
        } else {
            authCoordinator = AuthenticationCoordinator(rootNavigationViewController: self.rootNavigationViewController)
            _ = authCoordinator?.start()
            authCoordinator?.parentCoordinator = self
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
            guard let profileVC = profileCoordinator?.start() else {
                return UIViewController()
            }
            profileCoordinator?.parentCoordinator = self
            return profileVC
        } else {
            authCoordinator = AuthenticationCoordinator(rootNavigationViewController: self.rootNavigationViewController)
            guard let authVC = authCoordinator?.start() else {
                return UIViewController()
            }
            authCoordinator?.parentCoordinator = self
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
