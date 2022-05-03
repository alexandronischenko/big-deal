import Foundation

class SearchMainPresenter {
    // MARK: - Properties
    
    weak var input: SearchMainPresenterInputProtocol?
    var hotRepository: HotRepositoryProtocol?
    var coordinator: SearchBaseCoordinatorProtocol?
    
    var data: [Item] = DataManager.shared.data
    
    // MARK: - Initializers
    
    init(coordinator: SearchBaseCoordinatorProtocol, hotRepository: HotRepositoryProtocol) {
        self.coordinator = coordinator
        self.hotRepository = hotRepository
        
        updateData(data: data)
    }
    
    init(hotRepository: HotRepositoryProtocol) {
        self.hotRepository = hotRepository
    }
    
    init(coordinator: SearchBaseCoordinatorProtocol) {
        self.coordinator = coordinator
    }
}

extension SearchMainPresenter: SearchMainPresenterOutputProtocol {
    func updateData(data: [Item]) {
        input?.updateData(data: data)
    }
}

extension SearchMainPresenter: SearchBaseCoordinatedProtocol {
}
