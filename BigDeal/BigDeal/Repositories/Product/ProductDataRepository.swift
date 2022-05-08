import Foundation
import UIKit
import Alamofire

class ProductDataRepository: ProductRepositoryProtocol {
    // MARK: - Private properties
    
    private let remoteDataSource: ProductRemoteDataSourceProtocol
    private let localDataSource: ProductLocalDataSourceProtocol
    // MARK: - Initializers
    
    public init(remoteDataSource: ProductRemoteDataSourceProtocol, localDataSource: ProductLocalDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }
    // MARK: - Functions
    
    // Request from ASOS API
    
    func obtainProductByNameFromAsos(name: String, completion: @escaping(AFDataResponse<Any>) -> Void) {
        remoteDataSource.obtainProductByNameFromAsos(name: name) { response in
            completion(response)
        }
    }
    // Request from StockX API
    
    func obtainProductByNameFromStockX(name: String, completion: @escaping(AFDataResponse<Any>) -> Void) {
        remoteDataSource.obtainProductByNameFromStockX(name: name) { response in
            completion(response)
        }
    }
}
