import Foundation

protocol SearchBaseCoordinatorProtocol: FlowCoordinatorProtocol {
    
    // MARK: - Properties
    
    var parentCoordinator: MainBaseCoordinatorProtocol? { get set }
}
