import Foundation
import UIKit

protocol ProfileSubscriptionsPresenterOutputProtocol: AnyObject {
    func obtainDefaultButtonForBrandsCheckBoxController(_ brandsController: CheckBoxController) -> UIButton
    func obtainDefaultButtonForShopsCheckBoxController(_ shopsController: CheckBoxController) -> UIButton
}
