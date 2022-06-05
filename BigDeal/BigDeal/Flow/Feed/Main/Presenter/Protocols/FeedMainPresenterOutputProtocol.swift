import Foundation
import Alamofire

protocol FeedMainPresenterOutputProtocol: AnyObject {
    func updateData(data: [Item])
    func obtainHotProductsFromAsos(with parameters: Parameters?, headers: HTTPHeaders?, url: URLConvertible)
    func moveToDetailFlow(model: Item)
}
