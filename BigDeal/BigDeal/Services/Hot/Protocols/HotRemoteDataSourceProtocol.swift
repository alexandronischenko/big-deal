import Foundation
import Alamofire

protocol HotRemoteDataSourceProtocol: AnyObject {
    func obtainHotProductsFromAsos(with parameters: Parameters?, headers: HTTPHeaders?, url: URLConvertible, completion: @escaping(AFDataResponse<Any>) -> Void)
}
