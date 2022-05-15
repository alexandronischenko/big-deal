import Foundation
import UIKit

class SearchCoordinator {
    // MARK: - Protocol properties
    
    var rootViewController = UIViewController()
    var rootNavigationViewController: UINavigationController
    weak var parentCoordinator: MainBaseCoordinatorProtocol?
    
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
//        navigationRootViewController?.popToRootViewController(animated: true)
        rootNavigationViewController.popToRootViewController(animated: true)
    }
    
    private func moveToSearchFlowFilterScreen() {
        let searchFlowFilterViewController = UINavigationController(rootViewController: SearchFilterModuleBuilder().buildModule(coordinator: self))
        searchFlowFilterViewController.modalPresentationStyle = .automatic
        searchFlowFilterViewController.navigationBar.prefersLargeTitles = false
//        self.navigationRootViewController?.present(searchFlowFilterViewController, animated: true)
        self.rootNavigationViewController.present(searchFlowFilterViewController, animated: true)
    }
    
    private func moveToSearchFlowResultsScreen() {
        let searchFlowResultsViewController = SearchResultsModuleBuilder().buildModule(coordinator: self)
//        navigationRootViewController?.pushViewController(searchFlowResultsViewController, animated: true)
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
        
        let searchMainViewController = SearchMainModuleBuilder().buildModule(coordinator: self)
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
}
