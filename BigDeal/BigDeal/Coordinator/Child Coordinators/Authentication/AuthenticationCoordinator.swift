import Foundation
import UIKit

class AuthenticationCoordinator: AuthenticationBaseCoordinator {
    
    var parentCoordinator: MainBaseCoordinator?
    
    var rootViewController: UIViewController = UIViewController()
    
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
    
    func moveToAuthenticationFlow(with screen: AuthenticationScreen) {
        switch screen {
        case .greeting:
            moveToAuthenticationFlowGreetingScreen()
        case .login:
            moveToAuthenticationFlowLoginScreen()
        case .register:
            moveToAuthenticationFlowRegisterScreen()
        }
    }
    
    func moveToAuthenticationFlowGreetingScreen() {
        navigationRootViewController?.popToRootViewController(animated: true)
    }
    
    func moveToAuthenticationFlowLoginScreen() {
        let authenticationFlowLoginViewController = AuthenticationLoginScreenViewController()
        navigationRootViewController?.pushViewController(authenticationFlowLoginViewController, animated: true)
    }
    
    func moveToAuthenticationFlowRegisterScreen() {
        let authenticationFlowRegisterViewController = AuthenticationRegisterScreenViewController()
        navigationRootViewController?.pushViewController(authenticationFlowRegisterViewController, animated: true)
    }
}
