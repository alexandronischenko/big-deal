import Foundation

class FeedMainPresenter {
    // MARK: - Properties
    
    weak var input: FeedMainPresenterInputProtocol?
    var hotRepository: HotRepositoryProtocol?
    var coordinator: FeedBaseCoordinatorProtocol?
    
    var data: [Item] = DataManager.shared.data
    
    // MARK: - Initializers
    
    init(coordinator: FeedBaseCoordinatorProtocol, hotRepository: HotRepositoryProtocol) {
        self.coordinator = coordinator
        self.hotRepository = hotRepository
        
        updateData(data: data)
    }
    
    init(hotRepository: HotRepositoryProtocol) {
        self.hotRepository = hotRepository
    }
    
    init(coordinator: FeedBaseCoordinatorProtocol) {
        self.coordinator = coordinator
    }
}

extension FeedMainPresenter: FeedMainPresenterOutputProtocol {
    func updateData(data: [Item]) {
        input?.updateData(data: data)
    }
}

extension FeedMainPresenter: FeedBaseCoordinatedProtocol {
}
