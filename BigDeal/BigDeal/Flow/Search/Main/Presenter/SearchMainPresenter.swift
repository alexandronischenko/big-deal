import Foundation
import Alamofire

class SearchMainPresenter {
    // MARK: - Properties
    
    weak var input: SearchMainPresenterInputProtocol?
    var productRepository: ProductRepositoryProtocol?
    var coordinator: SearchBaseCoordinatorProtocol?
    
    var data: [Item] = DataManager.shared.itemsForSearch
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
    func moveToDetailFlow(model: Item) {
        coordinator?.moveTo(flow: .search(.detail(model)))
    }
    
    func updateData(data: [Item]) {
        input?.updateData(data: data)
    }
    
    func obtainProductByNameFromAsos(with parameters: Parameters?, headers: HTTPHeaders?, url: URLConvertible) {
        productRepository?.obtainProductByNameFromAsos(with: parameters, headers: headers, url: url) { [weak self] response in
            switch response.result {
            case .success:
                do {
                    guard let data = response.data else {
                        DispatchQueue.main.async {
                            self?.input?.stopAnimating()
                            self?.input?.dataCollectingErrorAlert()
                        }
                        return
                    }
                    let result = try JSONDecoder().decode(Asos.self, from: data)
                    guard let items = Item.getAsosArray(from: result.products) else {
                        DispatchQueue.main.async {
                            self?.input?.stopAnimating()
                            self?.input?.obtainArrayOfItemsAlert()
                        }
                        return
                    }
                    DataManager.shared.itemsForSearch += items
                    DispatchQueue.main.async {
                        self?.input?.stopAnimating()
                        self?.input?.reloadCollectionViewData()
                    }
                } catch {
                    DispatchQueue.main.async {
                        self?.input?.stopAnimating()
                        self?.input?.obtainDataErrorAlert(error: error)
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.input?.stopAnimating()
                    self?.input?.resposeResultFailureAlert(with: error)
                }
            }
        }
    }
    
    func searchMainFilterButtonDidPressed() {
        coordinator?.moveTo(flow: .search(.filter))
    }
    
    func searchMainCategoryButtonDidPressed(_ sender: UIButton) {
        var pressedButtonTitle: String?
        var categoryId: String?
        switch sender.currentTitle {
        case "Outerwear":
            pressedButtonTitle = CategoryButtonTitle.outwear.rawValue
            categoryId = Category.outwear.rawValue
        case "Sweatshirts":
            pressedButtonTitle = CategoryButtonTitle.sweatshirts.rawValue
            categoryId = Category.sweatshirts.rawValue
        case "T-shirts and tops":
            pressedButtonTitle = CategoryButtonTitle.tShirtsAndTops.rawValue
            categoryId = Category.tShirtsAndTops.rawValue
        case "Sneakers":
            pressedButtonTitle = CategoryButtonTitle.sneakers.rawValue
            categoryId = Category.sneakers.rawValue
        case "Perfume":
            pressedButtonTitle = CategoryButtonTitle.perfume.rawValue
            categoryId = Category.perfume.rawValue
        default:
            pressedButtonTitle = ""
            categoryId = ""
        }
        UserDefaults.standard.set(pressedButtonTitle, forKey: UserDefaultsKeys.keyForCategoryTitle)
        UserDefaults.standard.set(categoryId, forKey: UserDefaultsKeys.keyForCategoryId)
        coordinator?.moveTo(flow: .search(.results))
    }
}
// MARK: - SearchBaseCoordinatedProtocol

extension SearchMainPresenter: SearchBaseCoordinatedProtocol {
}
