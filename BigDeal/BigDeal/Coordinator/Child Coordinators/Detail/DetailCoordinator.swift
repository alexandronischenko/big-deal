//import Foundation
//import UIKit
//
//class DetailCoordinator {
//    // MARK: - Protocol properties
//    
//    var rootNavigationViewController: UINavigationController
//    var rootViewController = UIViewController()
//    weak var parentCoordinator: MainBaseCoordinatorProtocol?
//    
//    // the bottom link is weak so that there is no cycle of strong links
//    let mockItem = Item(shopTitle: "", clothTitle: "", sizes: ["1"], oldPrice: "", newPrice: "", clothImage: UIImage())
//    
//    init(rootNavigationViewController: UINavigationController) {
//        self.rootNavigationViewController = rootNavigationViewController
//    }
//    
//    // MARK: - Private funcs
//    
//    private func moveToDetailFlow(with screen: DetailScreen) {
//        switch screen {
//        case .main(let model):
//            moveToDetailFlowMainScreen(model: model)
//        }
//    }
//    
//    private func moveToDetailFlowMainScreen(model: Item) {
//        let detailScreenViewController = DetailItemBuilder(coordinator: self).build(model: model)
//        rootNavigationViewController.pushViewController(detailScreenViewController, animated: true)
//    }
//}
//
//extension DetailCoordinator: DetailBaseCoordinatorProtocol {
//    // Functions
//    
//    func start() -> UIViewController {
//        rootViewController = UINavigationController(rootViewController: DetailItemBuilder(coordinator: self).build(model: mockItem))
//        guard let navigationController = rootViewController as? UINavigationController else {
//            return UIViewController()
//        }
//        navigationController.navigationBar.prefersLargeTitles = true
//        return navigationController
//    }
//    
//    func moveTo(flow: AppFlow) {
//        switch flow {
//        case .detail(let detailScreen):
//            moveToDetailFlow(with: detailScreen)
//        default:
//            parentCoordinator?.moveTo(flow: flow)
//        }
//    }
//}
