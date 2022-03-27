import Foundation

protocol MainBaseCoordinator: FlowCoordinator {
    var profileCoordinator: ProfileBaseCoordinator { get set }
    var authenticationCoordinator: AuthenticationBaseCoordinator { get set }
    var feedCoordinator: FeedBaseCoordinator { get set }
    var searchCoordinator: SearchBaseCoordinator { get set }
}
