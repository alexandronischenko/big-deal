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
// MARK: - SearchMainPresenterOutputProtocol

extension SearchMainPresenter: SearchMainPresenterOutputProtocol {
    func updateData(data: [Item]) {
        input?.updateData(data: data)
    }
    func obtainProductByNameFromAsos(name: String, completion: @escaping(AFDataResponse<Any>) -> Void) {
        productRepository?.obtainProductByNameFromAsos(name: name) { response in
            completion(response)
        }
    }
    func obtainProductByNameFromStockX(name: String, completion: @escaping(AFDataResponse<Any>) -> Void) {
        productRepository?.obtainProductByNameFromStockX(name: name) { response in
            completion(response)
        }
    }
    func obtainProductByNameFromFarfetch(name: String, completion: @escaping(AFDataResponse<Any>) -> Void) {
        productRepository?.obtainProductByNameFromFarfetch(name: name) { response in
            completion(response)
        }
    }
    func searchMainFilterButtonDidPressed() {
        coordinator?.moveTo(flow: .search(.filter))
    }
    func searchMainCategoryButtonDidPressed(_ sender: UIButton) {
        var pressedButtonTitle: String?
        switch sender.currentTitle {
        case "Outerwear":
            pressedButtonTitle = CategoryButtonTitle.outwear.rawValue
        case "Sweatshirts":
            pressedButtonTitle = CategoryButtonTitle.sweatshirts.rawValue
        case "T-shirts and tops":
            pressedButtonTitle = CategoryButtonTitle.tShirtsAndTops.rawValue
        case "Sneakers":
            pressedButtonTitle = CategoryButtonTitle.sneakers.rawValue
        case "Perfume":
            pressedButtonTitle = CategoryButtonTitle.perfume.rawValue
        default:
            pressedButtonTitle = ""
        }
        coordinator?.moveTo(flow: .search(.results))
    }
}
// MARK: - SearchBaseCoordinatedProtocol

extension SearchMainPresenter: SearchBaseCoordinatedProtocol {
}
