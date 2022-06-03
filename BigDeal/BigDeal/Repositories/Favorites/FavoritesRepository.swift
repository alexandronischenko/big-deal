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
    
    func save(item: Item, completion: @escaping (Result<Item, Error>) -> Void) {
        let isLoggedIn = UserDefaults.standard.bool(forKey: UserDefaultsKeys.isLoggedInKey)
        if isLoggedIn {
            self.localDataSource.addToFavorites(item: item) { result in
                switch result {
                case .success(let item):
                    self.remoteDataSource.addToFavorites(item: item) { result in
                        switch result {
                        case .success(let item):
                            completion(.success(item))
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } else {
            completion(.failure(Errors.isNotLoggedIn))
        }
    }
    
    func obtainAll(completion: @escaping (Result<[Item], Error>) -> Void) {
        //        remoteDataSource.obtainFavorites { result in
        //            switch result {
        //            case .success(let remoteItems):
        //                self.localDataSource.obtainFavorites { result in
        //                    switch result {
        //                    case .success(let localItems):
        //                        if localItems == remoteItems {
        //                            completion(.success(localItems))
        //                        } else {
        //                            // Необходимо добавить недостающие элементы в другую базу
        //                            completion(.success(remoteItems))
        //                        }
        //                    case .failure(let error):
        //                        completion(.failure(error))
        //                    }
        //                }
        //            case .failure(let error):
        //                completion(.failure(error))
        //            }
        //        }
        
        self.localDataSource.obtainFavorites { result in
            switch result {
            case .success(let localItems):
                for i in 0..<localItems.count {
                    FileManagerService.shared.getImage(byID: localItems[i].imageURL, completion: { result in
                        switch result {
                        case .success(let image):
                            localItems[i].clothImage = image
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    })
                }
                print(localItems.description)
                completion(.success(localItems))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
