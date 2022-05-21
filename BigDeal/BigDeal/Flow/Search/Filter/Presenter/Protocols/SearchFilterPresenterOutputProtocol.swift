import Foundation
import UIKit

protocol SearchFilterPresenterOutputProtocol: AnyObject {
    func obtainDefaultButtonForSexRadioController(_ sexRadioController: RadioButtonController) -> UIButton
    func obtainDefaultButtonForSortByRadioController(_ sortByRadioController: RadioButtonController) -> UIButton
    func obtainDefaultButtonForPriceRangeRadioController(_ priceRangeController: RadioButtonController) -> UIButton
    func obtainDefaultButtonForCategoriesCheckBoxController(_ categoriesController: CheckBoxController) -> UIButton
    func obtainDefaultButtonForBrandsCheckBoxController(_ brandsController: CheckBoxController) -> UIButton
    func obtainDefaultButtonForSizesCheckBoxController(_ sizesController: CheckBoxController) -> UIButton
    func obtainDefaultButtonForShopsCheckBoxController(_ shopsController: CheckBoxController) -> UIButton
    func closeFilterAndLoadData()
}
