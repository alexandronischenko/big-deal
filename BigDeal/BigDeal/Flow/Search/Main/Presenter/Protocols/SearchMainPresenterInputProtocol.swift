import Foundation
import Alamofire

protocol SearchMainPresenterInputProtocol: AnyObject {
    func updateData(data: [Item])
    func obtainProductByNameFromAsos(name: String)
    func obtainProductByNameFromStockX(name: String)
    func dataCollectingErrorAlert() 
    func resposeResultFailureAlert(with error: AFError)
    func obtainDataErrorAlert(error: Error)
}
