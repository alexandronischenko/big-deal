import Foundation
import UIKit

class MainCoordinator {
    // MARK: - Private properties
    
    private var isLoggedIn = true
    
    // It's temporary version of useless isLoggedIn variable. In future i suggest it will be stored in UserDefaults.
    
    // MARK: - Protocol properties
    
    var profileCoordinator: ProfileBaseCoordinatorProtocol = ProfileCoordinator()
    var authenticationCoordinator: AuthenticationBaseCoordinatorProtocol = AuthenticationCoordinator()
    var feedCoordinator: FeedBaseCoordinatorProtocol = FeedCoordinator()
    var searchCoordinator: SearchBaseCoordinatorProtocol = SearchCoordinator()
    var rootViewController: UIViewController = UITabBarController()
    
    // MARK: - Private funcs
    
    private func checkoutProfile(with flow: AppFlow) {
        profileCoordinator.moveTo(flow: flow)
        (rootViewController as? UITabBarController)?.selectedIndex = 2
    }
    
    private func checkoutAuth(with flow: AppFlow) {
        authenticationCoordinator.moveTo(flow: flow)
        (rootViewController as? UITabBarController)?.selectedIndex = 2
    }
    
    private func checkoutSearch(with flow: AppFlow) {
        searchCoordinator.moveTo(flow: flow)
        (rootViewController as? UITabBarController)?.selectedIndex = 1
    }
    
    private func checkoutFeed(with flow: AppFlow) {
        feedCoordinator.moveTo(flow: flow)
        (rootViewController as? UITabBarController)?.selectedIndex = 0
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
        
        if isLoggedIn {
            let profileViewController = profileCoordinator.start()
            profileCoordinator.parentCoordinator = self
            profileViewController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.fill"), tag: 2)
            
            guard let viewControllerForLoggedUser = rootViewController as? UITabBarController else {
                return UIViewController()
            }
            viewControllerForLoggedUser.viewControllers = [feedViewController, searchViewController, profileViewController]
            
            rootViewController = viewControllerForLoggedUser
            return rootViewController
        } else {
            let authenticationViewController = authenticationCoordinator.start()
            authenticationCoordinator.parentCoordinator = self
            authenticationViewController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.fill"), tag: 2)
            
            guard let viewControllerForUnloggedUser = rootViewController as? UITabBarController else {
                return UIViewController()
            }
            viewControllerForUnloggedUser.viewControllers = [feedViewController, searchViewController, authenticationViewController]
            
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
}
