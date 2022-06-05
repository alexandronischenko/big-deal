import Foundation

protocol AuthenticationBaseCoordinatorProtocol: FlowCoordinatorProtocol {
    // MARK: - Properties
    
    var parentCoordinator: AuthenticationProfileBaseCoordinatorProtocol? { get set }
}
