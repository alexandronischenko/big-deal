import Foundation
import Alamofire
import UIKit

protocol SearchMainPresenterInputProtocol: AnyObject {
    func stopAnimating()
    func startAnimating()
    func dataCollectingErrorAlert()
    func obtainArrayOfItemsAlert()
    func resposeResultFailureAlert(with error: AFError)
    func obtainDataErrorAlert(error: Error)
    func reloadCollectionViewData()
}
