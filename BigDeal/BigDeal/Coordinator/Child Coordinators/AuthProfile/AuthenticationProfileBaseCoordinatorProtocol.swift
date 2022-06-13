import Foundation
import UIKit

protocol AuthenticationProfileBaseCoordinatorProtocol: FlowCoordinatorProtocol {
    // MARK: - Properties
    
    var profileCoordinator: ProfileBaseCoordinatorProtocol? { get set }
    var authCoordinator: AuthenticationBaseCoordinatorProtocol? { get set }
    var parentCoordinator: MainBaseCoordinatorProtocol? { get set }
    var rootNavigationViewController: UINavigationController { get set }
}
