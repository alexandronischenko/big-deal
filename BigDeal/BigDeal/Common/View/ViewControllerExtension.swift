import Foundation
import UIKit
import Alamofire

extension UIViewController {
    // UIAlertAction
    func dataCollectingErrorAlert() {
        guard let collectingError = String?(ErrorsDescriptions.collectingError.rawValue) else {
            return
        }
        let alertController = UIAlertController(title: "Data collecting error❗️", message: collectingError, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default) { _ in
            self.dismiss(animated: true, completion: nil)
        })
        self.present(alertController, animated: true, completion: nil)
    }
    
    func obtainArrayOfItemsAlert() {
        guard let arrayObtainingError = String?(ErrorsDescriptions.arrayObtainingError.rawValue) else {
            return
        }
        let alertController = UIAlertController(title: "Array getting error❗️", message: arrayObtainingError, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default) { _ in
            self.dismiss(animated: true, completion: nil)
        })
        self.present(alertController, animated: true, completion: nil)
    }
    
    func resposeResultFailureAlert(with error: AFError) {
        let alertController = UIAlertController(title: "Failure during request❗️", message: error.localizedDescription, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default) { _ in
            self.dismiss(animated: true, completion: nil)
        })
        self.present(alertController, animated: true, completion: nil)
    }
    
    func obtainDataErrorAlert(error: Error) {
        let alertController = UIAlertController(title: "Data processing error❗️", message: error.localizedDescription, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default) { _ in
            self.dismiss(animated: true, completion: nil)
        })
        self.present(alertController, animated: true, completion: nil)
    }
    // UIActivityIndicatorAction
    
    func startAnimating(view: UIActivityIndicatorView) {
        view.startAnimating()
    }
    
    func stopAnimating(view: UIActivityIndicatorView) {
        view.stopAnimating()
    }
}
