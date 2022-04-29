import Foundation
import UIKit

protocol ProfileSettingsPresenterOutputProtocol: AnyObject {
    func obtainDefaultButtonForSexRadioController(_ sexRadioController: RadioButtonController) -> UIButton
}
