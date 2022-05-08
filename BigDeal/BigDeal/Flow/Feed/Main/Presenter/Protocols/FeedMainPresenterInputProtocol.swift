import Foundation
import Alamofire

protocol FeedMainPresenterInputProtocol: AnyObject {
    func updateData(data: [Item])
    func obtainHotProductsFromStockX()
    func obtainHotProductsFromAsos()
    func dataCollectingErrorAlert()
    func resposeResultFailureAlert(with error: AFError)
    func obtainDataErrorAlert(error: Error)
}
