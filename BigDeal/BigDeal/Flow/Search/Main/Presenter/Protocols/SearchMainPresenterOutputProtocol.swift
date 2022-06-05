import Foundation
import Alamofire

protocol SearchMainPresenterOutputProtocol: AnyObject {
    func updateData(data: [Item])
    func obtainProductByNameFromAsos(with parameters: Parameters?, headers: HTTPHeaders?, url: URLConvertible)
    func searchMainFilterButtonDidPressed()
    func searchMainCategoryButtonDidPressed(_ sender: UIButton)
    func moveToDetailFlow(model: Item)
    func obtainProductByNameFromStockX(with parameters: Parameters?, headers: HTTPHeaders?, url: URLConvertible)
}
