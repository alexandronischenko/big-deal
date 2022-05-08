import Foundation
import Alamofire

protocol HotRepositoryProtocol: AnyObject {
    func obtainHotProductsFromAsos(completion: @escaping(AFDataResponse<Any>) -> Void)
    func obtainHotProductsFromStockX(completion: @escaping(AFDataResponse<Any>) -> Void)
}
