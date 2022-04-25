import Foundation

protocol AuthenticationProfileBaseCoordinatorProtocol: FlowCoordinatorProtocol {
    // MARK: - Properties
    
    var profileCoordinator: ProfileBaseCoordinatorProtocol? { get set }
    var authCoordinator: AuthenticationProfileBaseCoordinatorProtocol? { get set }
    var parentCoordinator: MainBaseCoordinatorProtocol? { get set }
}
