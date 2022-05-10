import Foundation
import Alamofire

class SearchResultsPresenter {
    // MARK: - Properties
    
    weak var input: SearchResultsPresenterInputProtocol?
    var coordinator: SearchBaseCoordinatorProtocol?
    var categoryRepository: CategoryRepositoryProtocol?
    
    // MARK: - Initializers

    init(coordinator: SearchBaseCoordinatorProtocol) {
        self.coordinator = coordinator
    }
}

extension SearchResultsPresenter: SearchResultsPresenterOutputProtocol {
    func moveToFilterScreen() {
        coordinator?.moveTo(flow: .search(.filter))
    }
    func moveToDetailFlow(model: Item) {
        coordinator?.moveTo(flow: .detail(.main(model)))
    }
    func obtainProductByCategoryIdFromAsos(_ categoryId: String, completion: @escaping (AFDataResponse<Any>) -> Void) {
        categoryRepository?.obtainProductByCategoryIdFromAsos(categoryId, completion: { response in
            completion(response)
        })
    }
}

extension SearchResultsPresenter: SearchBaseCoordinatedProtocol {}
