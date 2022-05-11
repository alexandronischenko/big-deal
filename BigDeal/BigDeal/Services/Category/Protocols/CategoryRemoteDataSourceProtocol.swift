import Foundation
import Alamofire

protocol CategoryRemoteDataSourceProtocol: AnyObject {
    func obtainProductByCategoryIdFromAsos(_ categoryId: String, completion: @escaping(AFDataResponse<Any>) -> Void)
}
