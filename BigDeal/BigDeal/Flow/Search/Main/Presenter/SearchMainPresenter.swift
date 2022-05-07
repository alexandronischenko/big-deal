import Foundation
import Alamofire

class SearchMainPresenter {
    // MARK: - Properties
    
    weak var input: SearchMainPresenterInputProtocol?
    var productRepository: ProductRepositoryProtocol?
    var coordinator: SearchBaseCoordinatorProtocol?
    
    var data: [Item] = DataManager.shared.data
    
    // MARK: - Initializers
    
    init(coordinator: SearchBaseCoordinatorProtocol, productRepository: ProductRepositoryProtocol) {
        self.coordinator = coordinator
        self.productRepository = productRepository
        
        updateData(data: data)
    }
    
    init(productRepository: ProductRepositoryProtocol) {
        self.productRepository = productRepository
    }
    
    init(coordinator: SearchBaseCoordinatorProtocol) {
        self.coordinator = coordinator
    }
}

extension SearchMainPresenter: SearchMainPresenterOutputProtocol {
    func updateData(data: [Item]) {
        input?.updateData(data: data)
    }
    func obtainProductByNameFromAsos(name: String, completion: @escaping(AFDataResponse<Any>) -> Void) {
        productRepository?.obtainProductByNameFromAsos(name: name) { response in
            completion(response)
        }
    }
}

extension SearchMainPresenter: SearchBaseCoordinatedProtocol {
}
