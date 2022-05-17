import Foundation
import Alamofire

protocol HotRepositoryProtocol: AnyObject {
    func obtainHotProductsFromAsos(with parameters: Parameters?, headers: HTTPHeaders?, url: URLConvertible, completion: @escaping(AFDataResponse<Any>) -> Void)
}
