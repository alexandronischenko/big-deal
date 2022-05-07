import Foundation
import Alamofire

protocol ProductRepositoryProtocol: AnyObject {
    func obtainProductByNameFromAsos(name: String, completion: @escaping(AFDataResponse<Any>) -> Void)
}
