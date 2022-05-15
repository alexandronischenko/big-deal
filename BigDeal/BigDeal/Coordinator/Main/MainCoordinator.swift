import Foundation
import UIKit

class MainCoordinator {
    // MARK: - Protocol properties
    
    var authProfileCoordinator: AuthenticationProfileBaseCoordinatorProtocol = AuthenticationProfileCoordinator(rootNavigationViewController: UINavigationController())
    var feedCoordinator: FeedBaseCoordinatorProtocol = FeedCoordinator(rootNavigationViewController: UINavigationController())
    var searchCoordinator: SearchBaseCoordinatorProtocol = SearchCoordinator(rootNavigationViewController: UINavigationController())
    var rootViewController: UIViewController = UITabBarController()
    // MARK: - Private functions

    private func checkoutFeed(with flow: AppFlow) {
        feedCoordinator.moveTo(flow: flow)
        (rootViewController as? UITabBarController)?.selectedIndex = 0
    }
    
    private func checkoutSearch(with flow: AppFlow) {
        searchCoordinator.moveTo(flow: flow)
        (rootViewController as? UITabBarController)?.selectedIndex = 1
    }
    
    private func checkoutAuthProfile(with flow: AppFlow) {
        authProfileCoordinator.moveTo(flow: flow)
        (rootViewController as? UITabBarController)?.selectedIndex = 2
    }
}
// MARK: - MainBaseCoordinatorProtocol

extension MainCoordinator: MainBaseCoordinatorProtocol {    
    // Functions
    
    func start() -> UIViewController {
        let feedViewController = feedCoordinator.start()
        feedCoordinator.parentCoordinator = self
        feedViewController.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "house.fill"), tag: 0)
        
        let searchViewController = searchCoordinator.start()
        searchCoordinator.parentCoordinator = self
        searchViewController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        
        let authProfileViewController = authProfileCoordinator.start()
        authProfileCoordinator.parentCoordinator = self
        authProfileViewController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.fill"), tag: 2)
        
        (rootViewController as? UITabBarController)?.viewControllers = [feedViewController, searchViewController, authProfileViewController]
        return rootViewController
    }
    
    func moveTo(flow: AppFlow) {
        switch flow {
        case .authProfile:
            checkoutAuthProfile(with: flow)
        case .feed:
            checkoutFeed(with: flow)
        case .search:
            checkoutSearch(with: flow)
        }
    }
}
