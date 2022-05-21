import Foundation
import Alamofire

protocol SearchResultsPresenterOutputProtocol: AnyObject {
    func moveToFilterScreen()
    func moveToDetailFlow(model: Item)
    func obtainProductByCategoryFromAsos(with parameters: Parameters?, headers: HTTPHeaders?, url: URLConvertible)
    func loadNewData(by indexPath: IndexPath)
}
