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
}
