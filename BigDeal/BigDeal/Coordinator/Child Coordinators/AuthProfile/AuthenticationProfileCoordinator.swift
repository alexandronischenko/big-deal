import Foundation
import UIKit

class AuthenticationProfileCoordinator {
    // MARK: - Properties
    
    var profileCoordinator: ProfileBaseCoordinatorProtocol?
    var authCoordinator: AuthenticationProfileBaseCoordinatorProtocol?
    var rootViewController = UIViewController()
    var rootNavigationViewController = UINavigationController()
    weak var parentCoordinator: MainBaseCoordinatorProtocol?
    
    private func checkoutProfile(with flow: AppFlow) {
        if let profileCoordinator = profileCoordinator {
            profileCoordinator.moveTo(flow: flow)
        } else {
            
        }
    }
    
    private func checkoutAuth(with flow: AppFlow) {
        if let authCoordinator = authCoordinator {
            authCoordinator.moveTo(flow: flow)
        } else {
            
        }
    }
}

extension AuthenticationProfileCoordinator: AuthenticationProfileBaseCoordinatorProtocol {
    func start() -> UIViewController {
        <#code#>
    }
    
    func moveTo(flow: AppFlow) {
        <#code#>
    }
}
