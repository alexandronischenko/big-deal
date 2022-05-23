import Foundation
import UIKit

protocol ProfileMainPresenterInputProtocol: AnyObject {
    func present(alert: UIAlertController)
    func getData(data: [Item])
}
