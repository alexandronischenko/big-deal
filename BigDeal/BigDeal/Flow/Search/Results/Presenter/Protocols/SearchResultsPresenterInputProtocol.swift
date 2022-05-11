import Foundation
import Alamofire

protocol SearchResultsPresenterInputProtocol: AnyObject {
    func obtainProductByCategoryIdFromAsos(_ categoryId: String)
    func dataCollectingErrorAlert()
    func resposeResultFailureAlert(with error: AFError)
    func obtainDataErrorAlert(error: Error)
}
