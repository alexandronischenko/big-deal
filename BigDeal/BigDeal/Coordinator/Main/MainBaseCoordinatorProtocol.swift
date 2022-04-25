import Foundation

protocol MainBaseCoordinatorProtocol: FlowCoordinatorProtocol {
    // MARK: - Properties
    
    var authProfileCoordinator: AuthenticationProfileBaseCoordinatorProtocol { get set }
    var feedCoordinator: FeedBaseCoordinatorProtocol { get set }
    var searchCoordinator: SearchBaseCoordinatorProtocol { get set }
    var detailCoordinator: DetailBaseCoordinatorProtocol { get set }
    
    // This is MainCoordinator's child coordinators which can be managed by them.
}
