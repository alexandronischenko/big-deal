import Foundation

protocol ProfileBaseCoordinator: FlowCoordinator {
    var parentCoordinator: MainBaseCoordinator? { get set }
}
