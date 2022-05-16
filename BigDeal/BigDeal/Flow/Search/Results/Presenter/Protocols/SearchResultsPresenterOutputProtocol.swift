import Foundation
import Alamofire

protocol SearchResultsPresenterOutputProtocol: AnyObject {
    func moveToFilterScreen()
    func moveToDetailFlow(model: Item)
    func obtainProductByCategoryIdFromAsos(_ categoryId: String, completion: @escaping(AFDataResponse<Any>) -> Void)
    func obtainProductByCategoryFromStockX(_ category: String, completion: @escaping (AFDataResponse<Any>) -> Void)
}
