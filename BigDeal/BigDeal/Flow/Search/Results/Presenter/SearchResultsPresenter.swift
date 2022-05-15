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

extension SearchResultsPresenter: SearchResultsPresenterOutputProtocol {
    func moveToFilterScreen() {
        coordinator?.moveTo(flow: .search(.filter))
    }
    
    func moveToDetailFlow(model: Item) {
        coordinator?.moveTo(flow: .search(.detail(model)))
    }
    
    func obtainProductByCategoryIdFromAsos(_ categoryId: String, completion: @escaping (AFDataResponse<Any>) -> Void) {
        categoryRepository?.obtainProductByCategoryIdFromAsos(categoryId, completion: { response in
            completion(response)
        })
    }
}

extension SearchResultsPresenter: SearchBaseCoordinatedProtocol {}
