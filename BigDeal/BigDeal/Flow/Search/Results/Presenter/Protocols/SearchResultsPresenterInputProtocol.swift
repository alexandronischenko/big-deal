import Foundation
import Alamofire

protocol SearchResultsPresenterInputProtocol: AnyObject {
    func stopAnimating()
    func startAnimating()
    func dataCollectingErrorAlert()
    func obtainArrayOfItemsAlert()
    func resposeResultFailureAlert(with error: AFError)
    func obtainDataErrorAlert(error: Error)
    func reloadCollectionViewData()
}
