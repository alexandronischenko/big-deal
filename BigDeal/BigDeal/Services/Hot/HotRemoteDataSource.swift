import Foundation
import Alamofire

class HotRemoteDataSource: HotRemoteDataSourceProtocol {
    // MARK: - Functions
    
    // Requests from ASOS API
    
    func obtainHotProductsFromAsos(with parameters: Parameters?, headers: HTTPHeaders?, url: URLConvertible, completion: @escaping(AFDataResponse<Any>) -> Void) {
        DispatchQueue.global(qos: .utility).async {
            AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.queryString, headers: headers).responseJSON { response in
                completion(response)
            }
        }
    }
}
