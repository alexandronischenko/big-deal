import Foundation
import Alamofire

class FeedMainPresenter {
    // MARK: - Properties
    
    weak var input: FeedMainPresenterInputProtocol?
    var hotRepository: HotRepositoryProtocol?
    var coordinator: FeedBaseCoordinatorProtocol?
    
    var data: [Item] = DataManager.shared.itemsForHot
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
// MARK: - FeedMainPresenterOutputProtocol

extension FeedMainPresenter: FeedMainPresenterOutputProtocol {
    func moveToDetailFlow(model: Item) {
        coordinator?.moveTo(flow: .feed(.detail(model)))
    }
    
    func updateData(data: [Item]) {
        input?.updateData(data: data)
    }
    
    func obtainHotProductsFromAsos(with parameters: Parameters?, headers: HTTPHeaders?, url: URLConvertible) {
        hotRepository?.obtainHotProductsFromAsos(with: parameters, headers: headers, url: url) { [weak self] response in
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
                    DataManager.shared.itemsForHot += items
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
// MARK: - FeedBaseCoordinatedProtocol

extension FeedMainPresenter: FeedBaseCoordinatedProtocol {
}

