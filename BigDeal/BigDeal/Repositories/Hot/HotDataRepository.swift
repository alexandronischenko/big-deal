import Foundation
import Alamofire

class HotDataRepository: HotRepositoryProtocol {
    // MARK: - Private properties
    
    private let remoteDataSource: HotRemoteDataSourceProtocol
    private let localDataSource: HotLocalDataSourceProtocol
    
    // MARK: - Initializers
    
    public init(remoteDataSource: HotRemoteDataSourceProtocol, localDataSource: HotLocalDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }
    // MARK: - Functions
    
    // Request to ASOS API
    
    func obtainHotProductsFromAsos(completion: @escaping(AFDataResponse<Any>) -> Void) {
        remoteDataSource.obtainHotProductsFromAsos { response in
            completion(response)
        }
    }
    // Request to StockX API
    
    func obtainHotProductsFromStockX(completion: @escaping(AFDataResponse<Any>) -> Void) {
        remoteDataSource.obtainHotProductsFromStockX { response in
            completion(response)
        }
    }
}
