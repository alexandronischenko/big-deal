import Foundation

class FeedMainPresenter {
    
    // MARK: - Properties
    
    weak var input: FeedMainPresenterInputProtocol?
    var hotRepository: HotRepositoryProtocol?
    var coordinator: FeedBaseCoordinatorProtocol?
    
    // MARK: - Initializers
    
    init(coordinator: FeedBaseCoordinatorProtocol, hotRepository: HotRepositoryProtocol) {
        self.coordinator = coordinator
        self.hotRepository = hotRepository
    }
    
    init(hotRepository: HotRepositoryProtocol) {
        self.hotRepository = hotRepository
    }
    
    init(coordinator: FeedBaseCoordinatorProtocol) {
        self.coordinator = coordinator
    }
}

extension FeedMainPresenter: FeedMainPresenterOutputProtocol {
    
}

extension FeedMainPresenter: FeedBaseCoordinatedProtocol {
    
}
