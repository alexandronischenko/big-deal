import Foundation
import Alamofire
import UIKit

protocol SearchMainPresenterInputProtocol: AnyObject {
    func updateData(data: [Item])
    func obtainProductByNameFromStockX(name: String)
    func obtainDataErrorAlert(error: Error)
    func stopAnimating(view: UIActivityIndicatorView)
    func startAnimating(view: UIActivityIndicatorView)
    func dataCollectingErrorAlert(view: UIViewController)
    func obtainArrayOfItemsAlert(view: UIViewController)
    func resposeResultFailureAlert(with error: AFError, view: UIViewController)
    func obtainDataErrorAlert(error: Error, view: UIViewController)
}
