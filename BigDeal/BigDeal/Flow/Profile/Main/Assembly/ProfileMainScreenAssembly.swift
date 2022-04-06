import Foundation
import UIKit

class ProfileMainScreenAssembly: NSObject {
    static let shared = ProfileMainScreenAssembly()
    
    func assembledModule() -> UIViewController {
        let viewController = ProfileMainScreenViewController()
        let presenter = ProfileMainScreenPresenter()
        let interactor = ProfileMainScreenIntaractor()
        let coordinator = ProfileCoordinator()
        
        viewController.profileMainScreenPresenter = presenter
        presenter.profileMainScreenViewController = viewController
        presenter.profileMainScreenInteractor = interactor
        interactor.profileMainScreenPresenter = presenter
        viewController.coordinator = coordinator
        
        return viewController
    }
}
