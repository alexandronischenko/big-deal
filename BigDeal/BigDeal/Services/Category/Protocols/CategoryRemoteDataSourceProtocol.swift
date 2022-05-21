import Foundation
import Alamofire

protocol CategoryRemoteDataSourceProtocol: AnyObject {
    func obtainProductByCategoryFromAsos(with parameters: Parameters?, headers: HTTPHeaders?, url: URLConvertible, completion: @escaping(AFDataResponse<Any>) -> Void)
}
