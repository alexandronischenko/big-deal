import Foundation
import Alamofire

protocol ProductRemoteDataSourceProtocol: AnyObject {
    func obtainProductByNameFromAsos(with parameters: Parameters?, headers: HTTPHeaders?, url: URLConvertible, completion: @escaping(AFDataResponse<Any>) -> Void)
    func obtainProductByNameFromStockX(with parameters: Parameters?, headers: HTTPHeaders?, url: URLConvertible, completion: @escaping(AFDataResponse<Any>) -> Void)
}
