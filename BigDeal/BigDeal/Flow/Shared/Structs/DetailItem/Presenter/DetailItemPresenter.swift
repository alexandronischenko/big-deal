import Foundation

protocol DetailItemPresenterProtocol: AnyObject {
    func buttonPressedGoToShopSite(url: String)
    func didTapAddToFavorites(model: Item, completion: @escaping (Result<Item, Error>) -> Void)
}

class DetailItemPresenter: DetailItemPresenterProtocol {
    // MARK: - Properties
    var coordinator: FlowCoordinatorProtocol?
    weak var view: DetailItemViewProtocol?
    var repository: FavoritesRepositoryProtocol?
    var model: Item?
    // MARK: - Initializers

    required init(coordinator: FlowCoordinatorProtocol, model: Item, repository: FavoritesRepositoryProtocol) {
        self.coordinator = coordinator
        self.model = model
        self.repository = repository
        view?.configureModel(model: model)
    }
    // MARK: - Functions

    func buttonPressedGoToShopSite(url: String) {
//        called in vc cause cant use this here
//        UIApplication.shared.open(url)
    }
    
    func didTapAddToFavorites(model: Item, completion: @escaping (Result<Item, Error>) -> Void) {
        repository?.save(item: model) { result in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func configureModel(model: Item) {
        CoreDataManager.shared.isFavorite(model: model) { result in
            switch result {
            case .failure:
                break
            case .success(let isFavorite):
                model.isFavorite = isFavorite
                DispatchQueue.main.async {
                    self.view?.configureModel(model: model)
                }
            }
        }
    }
}
