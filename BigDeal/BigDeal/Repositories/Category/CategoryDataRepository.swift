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
    
    func obtainProductByCategoryFromAsos(with parameters: Parameters?, headers: HTTPHeaders?, url: URLConvertible, completion: @escaping (AFDataResponse<Any>) -> Void) {
        remoteDataSource.obtainProductByCategoryFromAsos(with: parameters, headers: headers, url: url) { response in
            completion(response)
        }
    }
}
