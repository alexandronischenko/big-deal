import Foundation

protocol SearchBaseCoordinator: FlowCoordinator {
    var parentCoordinator: MainBaseCoordinator? { get set }
}
