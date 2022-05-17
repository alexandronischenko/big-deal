import Foundation
import Alamofire

protocol HotRepositoryProtocol: AnyObject {
    func obtainHotProductsFromAsos(completion: @escaping(AFDataResponse<Any>) -> Void)
}
