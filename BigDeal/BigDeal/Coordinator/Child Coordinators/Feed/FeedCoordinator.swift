import Foundation
import UIKit

class FeedCoordinator {
    // MARK: - Protocol properties
    
    var rootViewController = UIViewController()
    weak var parentCoordinator: MainBaseCoordinatorProtocol?
    
    // the bottom link is weak so that there is no cycle of strong links
    
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
        navigationRootViewController?.popToRootViewController(animated: true)
    }
    
    private func moveToDetailScreen(model: Item) {
        let detailViewController = DetailItemBuilder(coordinator: self).build(model: model)
        navigationRootViewController?.pushViewController(detailViewController, animated: true)
    }
}

// MARK: - FeedBaseCoordinatorProtocol

extension FeedCoordinator: FeedBaseCoordinatorProtocol {
    // Functions
    
    func start() -> UIViewController {
        rootViewController = UINavigationController(rootViewController: FeedMainModuleBuilder().buildModule(coordinator: self))
        guard let navigationController = rootViewController as? UINavigationController else {
            return UIViewController()
        }
        let accessTokenForAsosFeed = DataManager.shared.accessTokensForAsos["tokenForFeed"]
        let accessTokenForStockXFeed = DataManager.shared.accessTokensForStockX["tokenForFeed"]
        let accessTokenForFarfetchFeed = DataManager.shared.accessTokensForFarfetch["tokenForFeed"]
        
        KeychainManager.standard.save(accessTokenForAsosFeed, service: ApiServices.accessTokenForFeed.rawValue, account: ApiAccounts.asos.rawValue)
        KeychainManager.standard.save(accessTokenForStockXFeed, service: ApiServices.accessTokenForFeed.rawValue, account: ApiAccounts.stockX.rawValue)
        KeychainManager.standard.save(accessTokenForFarfetchFeed, service: ApiServices.accessTokenForFeed.rawValue, account: ApiAccounts.farfetch.rawValue)
        navigationController.navigationBar.prefersLargeTitles = true
        return rootViewController
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
