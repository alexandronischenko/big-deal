import Foundation
import Alamofire

class SearchResultsPresenter {
    // MARK: - Properties
    
    weak var input: SearchResultsPresenterInputProtocol?
    var coordinator: SearchBaseCoordinatorProtocol?
    var categoryRepository: CategoryRepositoryProtocol?
    // MARK: - Initializers
    
    init(coordinator: SearchBaseCoordinatorProtocol, categoryRepository: CategoryRepositoryProtocol) {
        self.coordinator = coordinator
        self.categoryRepository = categoryRepository
        self.coordinator?.delegate = self
    }

    init(coordinator: SearchBaseCoordinatorProtocol) {
        self.coordinator = coordinator
        self.coordinator?.delegate = self
    }
    
    init(categoryRepository: CategoryRepositoryProtocol) {
        self.categoryRepository = categoryRepository
    }
}
// MARK: - SearchResultsPresenterOutputProtocol

extension SearchResultsPresenter: SearchResultsPresenterOutputProtocol {
    func moveToFilterScreen() {
        coordinator?.moveTo(flow: .search(.filter))
    }
    
    func moveToDetailFlow(model: Item) {
        coordinator?.moveTo(flow: .search(.detail(model)))
    }
    
    func obtainProductByCategoryFromAsos(with parameters: Parameters?, headers: HTTPHeaders?, url: URLConvertible) {
        categoryRepository?.obtainProductByCategoryFromAsos(with: parameters, headers: headers, url: url) { [weak self] response in
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
                    let isSearchByFilters = UserDefaults.standard.bool(forKey: "isSearchByFilters")
                    if isSearchByFilters {
                        DataManager.shared.itemsForFilters += items
                    } else {
                        DataManager.shared.itemsForCategory += items
                    }
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
    
    func obtainProductByCategoryFromStockX(with parameters: Parameters?, headers: HTTPHeaders?, url: URLConvertible) {
        categoryRepository?.obtainProductByCategoryFromStockX(with: parameters, headers: headers, url: url) { [weak self] response in
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
                    let result = try JSONDecoder().decode(StockX.self, from: data)
                    guard let items = Item.getStockXArray(from: result.products) else {
                        DispatchQueue.main.async {
                            self?.input?.stopAnimating()
                            self?.input?.obtainArrayOfItemsAlert()
                        }
                        return
                    }
                    let isSearchByFilters = UserDefaults.standard.bool(forKey: "isSearchByFilters")
                    if isSearchByFilters {
                        DataManager.shared.itemsForFilters += items
                    } else {
                        DataManager.shared.itemsForCategory += items
                    }
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
}
// MARK: - SearchBaseCoordinatedProtocol

extension SearchResultsPresenter: SearchBaseCoordinatedProtocol {
}
// MARK: - SearchResultsFilterDelegateProtocol

extension SearchResultsPresenter: SearchResultsFilterDelegateProtocol {
    func loadNewData(by indexPath: IndexPath) {
        let ud = UserDefaults.standard
        guard let priceMin = ud.object(forKey: "priceMin") as? String, let priceMax = ud.object(forKey: "priceMax") as? String, let sortBy = ud.object(forKey: "sortBy") as? String else {
            return
        }
        let parameters = DataManager.shared.obtainParametersForAsosFilters(priceMin: priceMin, priceMax: priceMax, sortBy: sortBy, category: "25781")
        let service = ApiServices.accessTokenForCategories.rawValue
        let account = ApiAccounts.asos.rawValue
        guard let accessTokenForAsos = KeychainManager.standard.read(service: service, account: account, type: String.self) else {
            return
        }
        let accessTokenHeader = HTTPHeader(name: DataManager.shared.asosAccessTokenHeaderName, value: accessTokenForAsos)
        let url = DataManager.shared.asosProductsListUrl
        let headers: HTTPHeaders = [
            DataManager.shared.asosHostHeader,
            accessTokenHeader
        ]
        if indexPath.item == DataManager.shared.itemsForFilters.count - 1 {
            input?.animateSearchResultsView()
        } else {
            input?.startAnimating()
        }
        obtainProductByCategoryFromAsos(with: parameters, headers: headers, url: url)
        DataManager.shared.categoryRepositoryOffset += DataManager.shared.limit
    }
}
