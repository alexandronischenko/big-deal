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

extension SearchResultsPresenter: SearchResultsPresenterOutputProtocol {}

extension SearchResultsPresenter: SearchBaseCoordinatedProtocol {}
