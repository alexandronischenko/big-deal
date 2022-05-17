import Foundation
import Alamofire

class CategoryDataRepository: CategoryRepositoryProtocol {    
    // MARK: - Private properties
    
    private let remoteDataSource: CategoryRemoteDataSourceProtocol
    private let localDataSource: CategoryLocalDataSourceProtocol
    // MARK: - Initializers
 
    public init(remoteDataSource: CategoryRemoteDataSourceProtocol, localDataSource: CategoryLocalDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }
    // MARK: - Functions
    
    // Request to ASOS API
    
    func obtainProductByCategoryIdFromAsos(_ categoryId: String, completion: @escaping (AFDataResponse<Any>) -> Void) {
        remoteDataSource.obtainProductByCategoryIdFromAsos(categoryId) { response in
            completion(response)
        }
    }
    // Request to StockX API
    
    func obtainProductByCategoryFromStockX(_ category: String, completion: @escaping (AFDataResponse<Any>) -> Void) {
        remoteDataSource.obtainProductByCategoryFromStockX(category) { response in
            completion(response)
        }
    }
}
