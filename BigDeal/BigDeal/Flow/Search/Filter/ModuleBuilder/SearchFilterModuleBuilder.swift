import Foundation
import UIKit

class SearchFilterModuleBuilder {
    // MARK: - Properties
    
    var coordinator: SearchBaseCoordinatorProtocol
    // MARK: - Initializers
    
    init(coordinator: SearchBaseCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    // MARK: - Functions
    
    func buildModule() -> UIViewController {
        let presenter = SearchFilterPresenter(coordinator: self.coordinator)
        let viewController = SearchFilterViewController(output: presenter)
        presenter.input = viewController
        return viewController
    }
}
