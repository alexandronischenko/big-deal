import Foundation
import UIKit

class FeedCoordinator {
    // MARK: - Protocol properties
    
    var rootViewController = UIViewController()
    var rootNavigationViewController: UINavigationController
    weak var parentCoordinator: MainBaseCoordinatorProtocol?
    
    // the bottom link is weak so that there is no cycle of strong links
    
    // MARK: - Initializers
    
    init(rootNavigationViewController: UINavigationController) {
        self.rootNavigationViewController = rootNavigationViewController
    }
    // MARK: - Private funcs
    
    private func moveToFeedFlow(with screen: FeedScreen) {
        switch screen {
        case .main:
            moveToFeedFlowMainScreen()
        case .detail(let model):
            moveToDetailScreen(model: model)
        }
    }
    
    private func moveToFeedFlowMainScreen() {
        rootNavigationViewController.popToRootViewController(animated: true)
    }
    
    private func moveToDetailScreen(model: Item) {
        let detailViewController = DetailItemBuilder(coordinator: self).build(model: model)
        rootNavigationViewController.pushViewController(detailViewController, animated: true)
    }
}
// MARK: - FeedBaseCoordinatorProtocol

extension FeedCoordinator: FeedBaseCoordinatorProtocol {
    // Functions
    
    func start() -> UIViewController {
        let accessTokenForAsosFeed = DataManager.shared.accessTokensForAsos["tokenForFeed"]
        let accessTokenForStockXFeed = DataManager.shared.accessTokensForStockX["tokenForFeed"]
        let accessTokenForFarfetchFeed = DataManager.shared.accessTokensForFarfetch["tokenForFeed"]
        
        KeychainManager.standard.save(accessTokenForAsosFeed, service: ApiServices.accessTokenForFeed.rawValue, account: ApiAccounts.asos.rawValue)
        KeychainManager.standard.save(accessTokenForStockXFeed, service: ApiServices.accessTokenForFeed.rawValue, account: ApiAccounts.stockX.rawValue)
        KeychainManager.standard.save(accessTokenForFarfetchFeed, service: ApiServices.accessTokenForFeed.rawValue, account: ApiAccounts.farfetch.rawValue)
        
        let feedMainViewController = FeedMainModuleBuilder().buildModule(coordinator: self)
        rootViewController = feedMainViewController
        rootNavigationViewController.pushViewController(rootViewController, animated: true)
        rootNavigationViewController.navigationBar.prefersLargeTitles = true
        return rootNavigationViewController
    }
    
    func moveTo(flow: AppFlow) {
        switch flow {
        case .feed(let feedScreen):
            moveToFeedFlow(with: feedScreen)
        default:
            parentCoordinator?.moveTo(flow: flow)
        }
    }
}
