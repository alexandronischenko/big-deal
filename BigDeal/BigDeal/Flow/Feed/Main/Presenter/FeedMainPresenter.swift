import Foundation
import Alamofire

class FeedMainPresenter {
    // MARK: - Properties
    
    weak var input: FeedMainPresenterInputProtocol?
    var hotRepository: HotRepositoryProtocol?
    var coordinator: FeedBaseCoordinatorProtocol?
    
    var data: [Item] = []
    
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
    func moveToDetailFlow(model: Item) {
        coordinator?.moveTo(flow: .feed(.detail(model)))
    }
    
    func updateData(data: [Item]) {
        input?.updateData(data: data)
    }
    func obtainHotProductsFromAsos(completion: @escaping(AFDataResponse<Any>) -> Void) {
        hotRepository?.obtainHotProductsFromAsos { response in
            completion(response)
        }
    }
    func obtainHotProductsFromStockX(completion: @escaping(AFDataResponse<Any>) -> Void) {
        hotRepository?.obtainHotProductsFromStockX { response in
            completion(response)
        }
    }
}

extension FeedMainPresenter: FeedBaseCoordinatedProtocol {
}
