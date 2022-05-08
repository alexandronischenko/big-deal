import Foundation
import Alamofire

protocol FeedMainPresenterOutputProtocol: AnyObject {
    func updateData(data: [Item])
    func obtainHotProductsFromAsos(completion: @escaping(AFDataResponse<Any>) -> Void)
    func obtainHotProductsFromStockX(completion: @escaping(AFDataResponse<Any>) -> Void)
}
