import Foundation

class FavoritesRemoteDataSource: FavoritesDataSourceProtocol {
    func addToFavorites(item: Item, completion: @escaping (Result<Bool, Error>) -> Void) {
        DatabaseManager.shared.addToFavorites(model: item) { result in
            switch result {
            case .success(let bool):
                completion(.success(bool))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
