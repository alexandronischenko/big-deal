import Foundation
import UIKit

class AuthenticationCoordinator {
    
    // MARK: - Protocol properties
    
    var rootViewController: UIViewController = UIViewController()
    weak var parentCoordinator: MainBaseCoordinatorProtocol?
    
    // the bottom link is weak so that there is no cycle of strong links
    
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
        let authenticationFlowLoginViewController = AuthenticationLoginScreenViewController()
        navigationRootViewController?.pushViewController(authenticationFlowLoginViewController, animated: true)
    }
    
    private func moveToAuthenticationFlowRegisterScreen() {
        let authenticationFlowRegisterViewController = AuthenticationRegisterScreenViewController()
        navigationRootViewController?.pushViewController(authenticationFlowRegisterViewController, animated: true)
    }
}

// MARK: - AuthenticationBaseCoordinatorProtocol

extension AuthenticationCoordinator: AuthenticationBaseCoordinatorProtocol {
    
    // Funcs
    
    func start() -> UIViewController {
        rootViewController = UINavigationController(rootViewController: AuthenticationGreetingScreenViewController(coordinator: self))
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
