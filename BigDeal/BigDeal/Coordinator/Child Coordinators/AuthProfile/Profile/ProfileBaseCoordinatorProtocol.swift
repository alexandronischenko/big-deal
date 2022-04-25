import Foundation

protocol ProfileBaseCoordinatorProtocol: FlowCoordinatorProtocol {
    // MARK: - Properties
    
    var parentCoordinator: AuthenticationProfileBaseCoordinatorProtocol? { get set }
}
