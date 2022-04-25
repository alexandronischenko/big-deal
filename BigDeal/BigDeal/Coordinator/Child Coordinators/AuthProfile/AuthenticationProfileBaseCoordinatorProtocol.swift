import Foundation

protocol AuthenticationProfileBaseCoordinatorProtocol: FlowCoordinatorProtocol {
    // MARK: - Properties
    
    var parentCoordinator: MainBaseCoordinatorProtocol? {get set}
}
