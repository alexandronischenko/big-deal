import Foundation

class FavoritesLocalDataSource: FavoritesDataSourceProtocol {
    func addToFavorites(item: Item, completion: @escaping  (Result<Bool, Error>) -> Void) {
        CoreDataManager.shared.addToFavorites(model: item) { result in
            switch result {
            case .success(let bool):
                completion(.success(bool))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}