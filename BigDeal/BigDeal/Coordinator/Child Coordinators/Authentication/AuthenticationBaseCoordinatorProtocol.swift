import Foundation

protocol AuthenticationBaseCoordinatorProtocol: FlowCoordinatorProtocol {
    
    // MARK: - Properties
    
    var parentCoordinator: MainBaseCoordinatorProtocol? { get set }
}
