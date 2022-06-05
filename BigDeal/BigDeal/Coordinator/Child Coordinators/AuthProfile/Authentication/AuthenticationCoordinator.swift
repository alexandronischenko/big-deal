import Foundation
import UIKit

class AuthenticationCoordinator {
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
    
    private func moveToAuthenticationFlow(with screen: AuthenticationScreen) {
        switch screen {
        case .greeting:
            moveToAuthenticationFlowGreetingScreen()
        case .login:
            moveToAuthenticationFlowLoginScreen()
        case .register:
            moveToAuthenticationFlowRegisterScreen()
        }
    }
    
    private func moveToAuthenticationFlowGreetingScreen() {
        rootNavigationViewController.popToRootViewController(animated: true)
    }
    
    private func moveToAuthenticationFlowLoginScreen() {
        let authenticationFlowLoginViewController = AuthenticationLoginBuilder(coordinator: self).build()
        rootNavigationViewController.pushViewController(authenticationFlowLoginViewController, animated: true)
    }
    
    private func moveToAuthenticationFlowRegisterScreen() {
        let authenticationFlowRegisterViewController = AuthenticationRegisterBuilder(coordinator: self).build()
        rootNavigationViewController.pushViewController(authenticationFlowRegisterViewController, animated: true)
    }
}
// MARK: - AuthenticationBaseCoordinatorProtocol

extension AuthenticationCoordinator: AuthenticationBaseCoordinatorProtocol {    
    // Functions
    
    func start() -> UIViewController {
        let authGreetingVC = AuthenticationGreetingBuilder(coordinator: self).build()
        rootViewController = authGreetingVC
        return rootViewController
    }
    
    func moveTo(flow: AppFlow) {
        switch flow {
        case .authProfile(let appSubflow):
            switch appSubflow {
            case .profile:
                parentCoordinator?.moveTo(flow: flow)
            case .authentication(let authenticationScreen):
                moveToAuthenticationFlow(with: authenticationScreen)
            }
        default:
            parentCoordinator?.moveTo(flow: flow)
        }
    }
}
