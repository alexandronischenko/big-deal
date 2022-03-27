import Foundation

protocol FeedBaseCoordinator: FlowCoordinator {
    var parentCoordinator: MainBaseCoordinator? { get set }
}
