import Foundation
import Alamofire

protocol CategoryRepositoryProtocol: AnyObject {
    func obtainProductByCategoryFromAsos(with parameters: Parameters?, headers: HTTPHeaders?, url: URLConvertible, completion: @escaping(AFDataResponse<Any>) -> Void)
    func obtainProductByCategoryFromStockX(with parameters: Parameters?, headers: HTTPHeaders?, url: URLConvertible, completion: @escaping(AFDataResponse<Any>) -> Void)
}
