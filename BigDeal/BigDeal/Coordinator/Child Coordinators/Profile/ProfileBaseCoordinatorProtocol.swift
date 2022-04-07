import Foundation

protocol ProfileBaseCoordinatorProtocol: FlowCoordinatorProtocol {
    
    // MARK: - Properties
    
    var parentCoordinator: MainBaseCoordinatorProtocol? { get set }
}
