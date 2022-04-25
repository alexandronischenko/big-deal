import Foundation
import UIKit

class AuthenticationCoordinator {
    // MARK: - Protocol properties
    
    var rootNavigationViewController: UINavigationController
    var rootViewController = UIViewController()
    var parentCoordinator: AuthenticationProfileBaseCoordinatorProtocol?

    // the bottom link is weak so that there is no cycle of strong links
    
    init(rootNavigationViewController: UINavigationController) {
        self.rootNavigationViewController = rootNavigationViewController
    }
    
    // MARK: - Private properties
    
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
        navigationRootViewController?.popToRootViewController(animated: true)
    }
    
    private func moveToAuthenticationFlowLoginScreen() {
        let authenticationFlowLoginViewController = AuthenticationLoginBuilder(coordinator: self).build()
        navigationRootViewController?.pushViewController(authenticationFlowLoginViewController, animated: true)
    }
    
    private func moveToAuthenticationFlowRegisterScreen() {
        let authenticationFlowRegisterViewController = AuthenticationRegisterBuilder(coordinator: self).build()
        navigationRootViewController?.pushViewController(authenticationFlowRegisterViewController, animated: true)
    }
}

// MARK: - AuthenticationBaseCoordinatorProtocol

extension AuthenticationCoordinator: AuthenticationBaseCoordinatorProtocol {    
    // Functions
    
    func start() -> UIViewController {
        rootViewController = UINavigationController(rootViewController: AuthenticationGreetingBuilder(coordinator: self).build())
        return rootViewController
    }
    
    func moveTo(flow: AppFlow) {
        switch flow {
        case .authentication(let authenticationScreen):
            moveToAuthenticationFlow(with: authenticationScreen)
        default:
            parentCoordinator?.moveTo(flow: flow)
        }
    }
}
