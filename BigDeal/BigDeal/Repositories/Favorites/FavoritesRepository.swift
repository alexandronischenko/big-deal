import Foundation
import Alamofire

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
                            var obtainedItems: [Item] = []
                            for item in remoteItems {
                                let service = ApiServices.accessTokenForSearch.rawValue
                                let account = ApiAccounts.asos.rawValue
                                guard let accessTokenForAsos = KeychainManager.standard.read(service: service, account: account, type: String.self) else {
                                    return
                                }
                                let url = DataManager.shared.asosProductsListUrl
                                let searchingProduct = item.id
                                let parameters: Parameters? = DataManager.shared.obtainParametersForAsosSearch(searchingProduct)
                                let accessTokenHeader = HTTPHeader(name: DataManager.shared.asosAccessTokenHeaderName, value: accessTokenForAsos)
                                let headers: HTTPHeaders = [
                                    DataManager.shared.asosHostHeader,
                                    accessTokenHeader
                                ]
                                AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.queryString, headers: headers).responseJSON { response in
                                    switch response.result {
                                    case .success:
                                        do {
                                            guard let data = response.data else {
                                                return
                                            }
                                            let result = try JSONDecoder().decode(Asos.self, from: data)
                                            guard let items = Item.getAsosArray(from: result.products) else {
                                                return
                                            }
                                            obtainedItems.append(contentsOf: items)
                                        } catch let error {
                                            completion(.failure(error))
                                        }
                                    case .failure(let error):
                                        completion(.failure(error))
                                    }
                                }
                            }
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
                Logger.log(level: .info, str: "\(localItems.description) ", shouldLogContext: true)
                completion(.success(localItems))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
