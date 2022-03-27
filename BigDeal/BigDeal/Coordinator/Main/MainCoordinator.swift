import Foundation
import UIKit

class MainCoordinator: MainBaseCoordinator {
    
    var isLoggedIn: Bool = false
    
    var profileCoordinator: ProfileBaseCoordinator = ProfileCoordinator()
    var authenticationCoordinator: AuthenticationBaseCoordinator = AuthenticationCoordinator()
    var feedCoordinator: FeedBaseCoordinator = FeedCoordinator()
    var searchCoordinator: SearchBaseCoordinator = SearchCoordinator()
    
    
    var viewControllerForLoggedUser: UIViewController = UITabBarController()
    var viewControllerForUnloggedUser: UIViewController = UITabBarController()
    var rootViewController: UIViewController = UITabBarController()
    
    func start() -> UIViewController {
        
        let feedViewController = feedCoordinator.start()
        feedCoordinator.parentCoordinator = self
        feedViewController.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "house.fill"), tag: 0)
        
        let searchViewController = searchCoordinator.start()
        searchCoordinator.parentCoordinator = self
        searchViewController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        
        if isLoggedIn {
            let profileViewController = profileCoordinator.start()
            profileCoordinator.parentCoordinator = self
            profileViewController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.fill"), tag: 2)
            
            (viewControllerForLoggedUser as? UITabBarController)?.viewControllers = [feedViewController, searchViewController, profileViewController]
            
            rootViewController = viewControllerForLoggedUser
            return rootViewController
        } else {
            let authenticationViewController = authenticationCoordinator.start()
            authenticationCoordinator.parentCoordinator = self
            authenticationViewController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.fill"), tag: 2)
            
            (viewControllerForUnloggedUser as? UITabBarController)?.viewControllers = [feedViewController, searchViewController, authenticationViewController]
            
            rootViewController = viewControllerForUnloggedUser
            return rootViewController
        }
    }
    
    func moveTo(flow: AppFlow) {
        switch flow {
        case .profile:
            checkoutProfile(with: flow)
        case .authentication:
            checkoutAuth(with: flow)
        case .feed:
            checkoutFeed(with: flow)
        case .search:
            checkoutSearch(with: flow)
        }
    }
    
    func checkoutProfile(with flow: AppFlow) {
        profileCoordinator.moveTo(flow: flow)
        (rootViewController as? UITabBarController)?.selectedIndex = 2
    }
    
    func checkoutAuth(with flow: AppFlow) {
        authenticationCoordinator.moveTo(flow: flow)
        (rootViewController as? UITabBarController)?.selectedIndex = 2
    }
    
    func checkoutSearch(with flow: AppFlow) {
        searchCoordinator.moveTo(flow: flow)
        (rootViewController as? UITabBarController)?.selectedIndex = 1
    }
    
    func checkoutFeed(with flow: AppFlow) {
        feedCoordinator.moveTo(flow: flow)
        (rootViewController as? UITabBarController)?.selectedIndex = 0
    }
}
