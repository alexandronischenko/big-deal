import Foundation

class SearchResultsPresenter {
    // MARK: - Properties
    
    weak var input: SearchResultsPresenterInputProtocol?
    var coordinator: SearchBaseCoordinatorProtocol?
    
    // MARK: - Initializers

    init(coordinator: SearchBaseCoordinatorProtocol) {
        self.coordinator = coordinator
    }
}

extension SearchResultsPresenter: SearchResultsPresenterOutputProtocol {
    func moveToFilterScreen() {
        coordinator?.moveTo(flow: .search(.filter))
    }
    func moveToDetailFlow() {
        coordinator?.moveTo(flow: .detail(.main))
    }
}

extension SearchResultsPresenter: SearchBaseCoordinatedProtocol {}
