import Foundation
import Alamofire

class ProductRemoteDataSource: ProductRemoteDataSourceProtocol {
    // MARK: - Private properties
    
    private let accessTokenForAsos = KeychainManager.standard.read(service: ApiServices.accessTokenForSearch.rawValue, account: ApiAccounts.asos.rawValue, type: String.self)
    private let accessTokenForStockX = KeychainManager.standard.read(service: ApiServices.accessTokenForSearch.rawValue, account: ApiAccounts.stockX.rawValue, type: String.self)
    private let accessTokenForFarfetch = KeychainManager.standard.read(service: ApiServices.accessTokenForSearch.rawValue, account: ApiAccounts.farfetch.rawValue, type: String.self)
    // MARK: - Functions
    
    // Requests to ASOS API
    
    func obtainProductByNameFromAsos(with parameters: Parameters?, headers: HTTPHeaders?, url: URLConvertible, completion: @escaping(AFDataResponse<Any>) -> Void) {
        DispatchQueue.global(qos: .utility).async {
            AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.queryString, headers: headers).responseJSON { response in
                completion(response)
            }
        }
    }
}
