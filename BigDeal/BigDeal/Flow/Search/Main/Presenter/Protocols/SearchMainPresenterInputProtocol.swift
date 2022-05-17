import Foundation
import Alamofire

protocol SearchMainPresenterInputProtocol: AnyObject {
    func updateData(data: [Item])
    func obtainProductByNameFromStockX(name: String)
    func obtainDataErrorAlert(error: Error)
}
