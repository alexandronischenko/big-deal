import Foundation
import Alamofire

protocol CategoryRepositoryProtocol: AnyObject {
    func obtainProductByCategoryIdFromAsos(_ categoryId: String, completion: @escaping(AFDataResponse<Any>) -> Void)
}
