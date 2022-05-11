import Foundation
import Alamofire

protocol SearchMainPresenterOutputProtocol: AnyObject {
    func updateData(data: [Item])
    func obtainProductByNameFromAsos(name: String, completion: @escaping(AFDataResponse<Any>) -> Void)
    func obtainProductByNameFromStockX(name: String, completion: @escaping(AFDataResponse<Any>) -> Void)
    func obtainProductByNameFromFarfetch(name: String, completion: @escaping(AFDataResponse<Any>) -> Void)
    func searchMainFilterButtonDidPressed()
    func searchMainCategoryButtonDidPressed(_ sender: UIButton)
}
