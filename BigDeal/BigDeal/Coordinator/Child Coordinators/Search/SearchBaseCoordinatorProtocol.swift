import Foundation

protocol SearchBaseCoordinatorProtocol: FlowCoordinatorProtocol {
    // MARK: - Properties
    
    var parentCoordinator: MainBaseCoordinatorProtocol? { get set }
    var delegate: SearchResultsFilterDelegateProtocol? { get set }
    
    func closeFilterAndLoadNewData()
}
