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
    func moveToDetailFlow(model: Item) {
        coordinator?.moveTo(flow: .detail(.main(model)))
    }
}

extension SearchResultsPresenter: SearchBaseCoordinatedProtocol {}
