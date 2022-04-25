import Foundation
import UIKit

class AuthenticationProfileCoordinator {
    var rootViewController = UIViewController()
    weak var parentCoordinator: MainBaseCoordinatorProtocol?
}

extension AuthenticationProfileCoordinator: AuthenticationProfileBaseCoordinatorProtocol {
    func start() -> UIViewController {
        <#code#>
    }
    
    func moveTo(flow: AppFlow) {
        <#code#>
    }
}
