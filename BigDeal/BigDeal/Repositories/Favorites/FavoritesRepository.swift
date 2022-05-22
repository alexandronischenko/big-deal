import Foundation

class FavoritesRepository: FavoritesRepositoryProtocol {
    // MARK: - Properties
    
    private let remoteDataSource: FavoritesDataSourceProtocol
    private let localDataSource: FavoritesDataSourceProtocol
    
    // MARK: - Initializers
    
    public init(remoteDataSource: FavoritesDataSourceProtocol, localDataSource: FavoritesDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }
    
    // MARK: - Functions

    func save(item: Item, completion: @escaping (Result<Bool, Error>) -> Void) {
        remoteDataSource.addToFavorites(item: item) { result in
            switch result {
            case .success(let bool):
                if bool {
                    self.localDataSource.addToFavorites(item: item) { result in
                        switch result {
                        case .success(let bool):
                            completion(.success(bool))
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func obtainAll(completion: @escaping (Result<[Item], Error>) -> Void) {
        remoteDataSource.obtainFavorites { result in
            switch result {
            case .success(let remoteItems):
                self.localDataSource.obtainFavorites { result in
                    switch result {
                    case .success(let localItems):
                        if localItems == remoteItems {
                            completion(.success(localItems))
                        } else {
                            // Необходимо добавить недостающие элементы в другую базу
                            completion(.success(remoteItems))
                        }
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
