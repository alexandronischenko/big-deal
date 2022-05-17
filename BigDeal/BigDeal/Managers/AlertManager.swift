import Foundation
import UIKit
import Alamofire

class AlertManager {
    // MARK: - Static properties
    static let standard = AlertManager()
    
    // MARK: - Functions
    func dataCollectingErrorAlert(view: UIViewController) {
        guard let collectingError = String?(ErrorsDescriptions.collectingError.rawValue) else {
            return
        }
        let alertController = UIAlertController(title: "Data collecting error❗️", message: collectingError, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default) { _ in
            view.dismiss(animated: true, completion: nil)
        })
        view.present(alertController, animated: true, completion: nil)
    }
    
    func obtainArrayOfItemsAlert(view: UIViewController) {
        guard let arrayObtainingError = String?(ErrorsDescriptions.arrayObtainingError.rawValue) else {
            return
        }
        let alertController = UIAlertController(title: "Array getting error❗️", message: arrayObtainingError, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default) { _ in
            view.dismiss(animated: true, completion: nil)
        })
        view.present(alertController, animated: true, completion: nil)
    }

    func resposeResultFailureAlert(with error: AFError, view: UIViewController) {
        let alertController = UIAlertController(title: "Failure during request❗️", message: error.localizedDescription, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default) { _ in
            view.dismiss(animated: true, completion: nil)
        })
        view.present(alertController, animated: true, completion: nil)
    }

    func obtainDataErrorAlert(error: Error, view: UIViewController) {
        let alertController = UIAlertController(title: "Data processing error❗️", message: error.localizedDescription, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default) { _ in
            view.dismiss(animated: true, completion: nil)
        })
        view.present(alertController, animated: true, completion: nil)
    }
}
