import Foundation

protocol DetailItemPresenterProtocol: AnyObject {
    func buttonPressedGoToShopSite(url: String)
    func didTapAddToFavorites(model: Item, completion: @escaping (Result<Item, Error>) -> Void)
}

class DetailItemPresenter: DetailItemPresenterProtocol {
    var coordinator: FlowCoordinatorProtocol?
    weak var view: DetailItemViewProtocol?
    var repository: FavoritesRepositoryProtocol?
    var model: Item?

    required init(coordinator: FlowCoordinatorProtocol, model: Item, repository: FavoritesRepositoryProtocol) {
        self.coordinator = coordinator
        self.model = model
        self.repository = repository
        view?.configureModel(model: model)
    }

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
                print("Error: \(error.localizedDescription) in \(#function)")
                completion(.failure(error))
            }
        }
    }
}
