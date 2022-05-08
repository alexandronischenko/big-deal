import Foundation
import Alamofire

protocol ProductRemoteDataSourceProtocol: AnyObject {
    func obtainProductByNameFromAsos(name: String, completion: @escaping(AFDataResponse<Any>) -> Void)
    func obtainProductByNameFromStockX(name: String, completion: @escaping(AFDataResponse<Any>) -> Void)
}
