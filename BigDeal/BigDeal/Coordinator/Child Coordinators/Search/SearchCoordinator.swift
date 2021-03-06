import Foundation
import UIKit

protocol SearchResultsFilterDelegateProtocol: AnyObject {
    func loadNewData(by indexPath: IndexPath)
}

class SearchCoordinator {
    // MARK: - Protocol properties
    
    var rootViewController = UIViewController()
    var rootNavigationViewController: UINavigationController
    weak var searchFlowFilterViewController: UINavigationController?
    weak var parentCoordinator: MainBaseCoordinatorProtocol?
    weak var delegate: SearchResultsFilterDelegateProtocol?
    
    // the bottom link is weak so that there is no cycle of strong links
    
    // MARK: - Initializers
    
    init(rootNavigationViewController: UINavigationController) {
        self.rootNavigationViewController = rootNavigationViewController
    }
    // MARK: - Private functions
    
    private func moveToSearchFlow(with screen: SearchScreen) {
        switch screen {
        case .main:
            moveToSearchFlowMainScreen()
        case .filter:
            moveToSearchFlowFilterScreen()
        case .results:
            moveToSearchFlowResultsScreen()
        case .detail(let model):
            moveToDetailScreen(model: model)
        }
    }
    
    private func moveToSearchFlowMainScreen() {
        rootNavigationViewController.popToRootViewController(animated: true)
    }
    
    private func moveToSearchFlowFilterScreen() {
        let searchFlowFilterViewController = UINavigationController(rootViewController: SearchFilterModuleBuilder(coordinator: self).buildModule())
        searchFlowFilterViewController.modalPresentationStyle = .automatic
        searchFlowFilterViewController.navigationBar.prefersLargeTitles = true
        rootNavigationViewController.present(searchFlowFilterViewController, animated: true)
        self.searchFlowFilterViewController = searchFlowFilterViewController
    }
    
    private func moveToSearchFlowResultsScreen() {
        let searchFlowResultsViewController = SearchResultsModuleBuilder(coordinator: self).buildModule()
        rootNavigationViewController.pushViewController(searchFlowResultsViewController, animated: true)
    }
    
    private func moveToDetailScreen(model: Item) {
        let detailViewController = DetailItemBuilder(coordinator: self).build(model: model)
        rootNavigationViewController.pushViewController(detailViewController, animated: true)
    }
}
// MARK: - SearchBaseCoordinatorProtocol

extension SearchCoordinator: SearchBaseCoordinatorProtocol {
    // Functions
    
    func start() -> UIViewController {
        let accessTokenForAsosSearch = DataManager.shared.accessTokensForAsos["tokenForSearch"]
        let accessTokenForStockXSearch = DataManager.shared.accessTokensForStockX["tokenForSearch"]
        let accessTokenForFarfetchSearch = DataManager.shared.accessTokensForFarfetch["tokenForSearch"]
        
        let accessTokenForAsosCategories = DataManager.shared.accessTokensForAsos["tokenForCategories"]
        let accessTokenForStockXCategories = DataManager.shared.accessTokensForStockX["tokenForCategories"]
        let accessTokenForFarfetchCategories = DataManager.shared.accessTokensForFarfetch["tokenForCategories"]
        
        KeychainManager.standard.save(accessTokenForAsosSearch, service: ApiServices.accessTokenForSearch.rawValue, account: ApiAccounts.asos.rawValue)
        KeychainManager.standard.save(accessTokenForStockXSearch, service: ApiServices.accessTokenForSearch.rawValue, account: ApiAccounts.stockX.rawValue)
        KeychainManager.standard.save(accessTokenForFarfetchSearch, service: ApiServices.accessTokenForSearch.rawValue, account: ApiAccounts.farfetch.rawValue)
        
        KeychainManager.standard.save(accessTokenForAsosCategories, service: ApiServices.accessTokenForCategories.rawValue, account: ApiAccounts.asos.rawValue)
        KeychainManager.standard.save(accessTokenForStockXCategories, service: ApiServices.accessTokenForCategories.rawValue, account: ApiAccounts.stockX.rawValue)
        KeychainManager.standard.save(accessTokenForFarfetchCategories, service: ApiServices.accessTokenForCategories.rawValue, account: ApiAccounts.farfetch.rawValue)
        
        let searchMainViewController = SearchMainModuleBuilder(coordinator: self).buildModule()
        rootViewController = searchMainViewController
        rootNavigationViewController.pushViewController(rootViewController, animated: true)
        rootNavigationViewController.navigationBar.prefersLargeTitles = true
        return rootNavigationViewController
    }
    
    func moveTo(flow: AppFlow) {
        switch flow {
        case .search(let searchScreen):
            moveToSearchFlow(with: searchScreen)
        default:
            parentCoordinator?.moveTo(flow: flow)
        }
    }
    
    func closeFilterAndLoadNewData() {
        searchFlowFilterViewController?.dismiss(animated: true) {
            self.moveTo(flow: .search(.results))
            self.delegate?.loadNewData(by: IndexPath(item: 0, section: 0))
            UserDefaults.standard.set("Men's sale", forKey: "titleForFiltersSearch")
        }
    }
}
