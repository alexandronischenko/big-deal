import Foundation

protocol FeedBaseCoordinatorProtocol: FlowCoordinatorProtocol {
    // MARK: - Properties
    
    var parentCoordinator: MainBaseCoordinatorProtocol? { get set }
}
