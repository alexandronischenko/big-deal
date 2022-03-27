import Foundation

protocol AuthenticationBaseCoordinator: FlowCoordinator {
    var parentCoordinator: MainBaseCoordinator? { get set }
}
