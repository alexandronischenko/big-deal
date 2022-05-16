import Foundation
import Alamofire

protocol CategoryRemoteDataSourceProtocol: AnyObject {
    func obtainProductByCategoryIdFromAsos(_ categoryId: String, completion: @escaping(AFDataResponse<Any>) -> Void)
    func obtainProductByCategoryFromStockX(_ category: String, completion: @escaping(AFDataResponse<Any>) -> Void)
}
