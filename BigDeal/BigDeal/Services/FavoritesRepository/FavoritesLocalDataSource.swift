import Foundation

class FavoritesLocalDataSource: FavoritesDataSourceProtocol {
    func addToFavorites(item: Item, completion: @escaping  (Result<Item, Error>) -> Void) {
        CoreDataManager.shared.addToFavorites(model: item) { result in
            switch result {
            case .success(let item):
                completion(.success(item))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func obtainFavorites(completion: @escaping (Result<[Item], Error>) -> Void) {
        CoreDataManager.shared.getAllFavorites { result in
            switch result {
            case .success(let items):
                completion(.success(items))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
