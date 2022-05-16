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
    
    // Request to ASOS API
    
    func obtainProductByNameFromAsos(with parameters: Parameters?, headers: HTTPHeaders?, url: URLConvertible, completion: @escaping(AFDataResponse<Any>) -> Void) {
        remoteDataSource.obtainProductByNameFromAsos(with: parameters, headers: headers, url: url) { response in
            completion(response)
        }
    }
    // Request to StockX API
    
    func obtainProductByNameFromStockX(name: String, completion: @escaping(AFDataResponse<Any>) -> Void) {
        remoteDataSource.obtainProductByNameFromStockX(name: name) { response in
            completion(response)
        }
    }
    // Request to Farfetch API
    
    func obtainProductByNameFromFarfetch(name: String, completion: @escaping(AFDataResponse<Any>) -> Void) {
        remoteDataSource.obtainProductByNameFromFarfetch(name: name) { response in
            completion(response)
        }
    }
}
