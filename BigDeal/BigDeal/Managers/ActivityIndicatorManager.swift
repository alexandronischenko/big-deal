import Foundation
import UIKit

class ActivityIndicatorManager {
    // MARK: - Static properties
    
    static let standard = ActivityIndicatorManager()
    // MARK: - Functions
    
    func startAnimating(view: UIActivityIndicatorView) {
        view.startAnimating()
    }
    
    func stopAnimating(view: UIActivityIndicatorView) {
        view.stopAnimating()
    }
}
