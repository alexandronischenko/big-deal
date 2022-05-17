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
    
    func obtainHotProductsFromAsos(with parameters: Parameters?, headers: HTTPHeaders?, url: URLConvertible, completion: @escaping (AFDataResponse<Any>) -> Void) {
        remoteDataSource.obtainHotProductsFromAsos(with: parameters, headers: headers, url: url) { response in
            completion(response)
        }
    }
}
