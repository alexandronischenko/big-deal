import Foundation
import UIKit

protocol FlowCoordinatorProtocol: AnyObject {
    // MARK: - Properties
    
    var rootViewController: UIViewController { get set }
    
    // MARK: - Major funcs
    
    func start() -> UIViewController
    
    /*
    Returns rootViewController which is inital controller in child coordinators.
    In MainCoordinator returns UITabBarController() with modified rootViewControllers of other coordinators.
    */
    
    func moveTo(flow: AppFlow)
    
    /*
    Switches among flow at MainCoordinator by AppFlow enum.
    In child coordinators swithces between screen of selected flow.
    */
}

extension FlowCoordinatorProtocol {
    // MARK: - Properties
    
    var navigationRootViewController: UINavigationController? {
        (rootViewController as? UINavigationController)
    }
}
