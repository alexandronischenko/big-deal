import Foundation
import Alamofire

protocol FeedMainPresenterInputProtocol: AnyObject {
    func updateData(data: [Item])
    func stopAnimating()
    func startAnimating()
    func dataCollectingErrorAlert()
    func obtainArrayOfItemsAlert()
    func resposeResultFailureAlert(with error: AFError)
    func obtainDataErrorAlert(error: Error)
    func reloadCollectionViewData()
}
