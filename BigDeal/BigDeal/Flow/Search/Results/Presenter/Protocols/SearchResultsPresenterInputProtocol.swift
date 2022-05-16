import Foundation
import Alamofire

protocol SearchResultsPresenterInputProtocol: AnyObject {
    func obtainProductByCategoryIdFromAsos(_ categoryId: String)
    func obtainProductByCategoryFromStockX(_ category: String)
}
