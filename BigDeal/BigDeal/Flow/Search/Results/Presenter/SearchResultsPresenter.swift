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
    }

    init(coordinator: SearchBaseCoordinatorProtocol) {
        self.coordinator = coordinator
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
                    DataManager.shared.itemsForCategory += items
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
