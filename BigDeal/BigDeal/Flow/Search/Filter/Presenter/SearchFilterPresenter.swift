import Foundation
import UIKit

class SearchFilterPresenter {
    // MARK: - Properties
    
    weak var input: SearchFilterPresenterInputProtocol?
    var coordinator: SearchBaseCoordinatorProtocol?
    
    // MARK: - Initializers
    
    init(coordinator: SearchBaseCoordinatorProtocol) {
        self.coordinator = coordinator
    }
}

// MARK: - SearchFilterPresenterOutputProtocol

extension SearchFilterPresenter: SearchFilterPresenterOutputProtocol {
    func obtainDefaultButtonForSexRadioController(_ sexRadioController: RadioButtonController) -> UIButton {
        guard let defaultButtonForSexCategory = sexRadioController.buttonsArray.first(where: { $0.currentTitle == "Male" }) else {
            return UIButton()
        }
        return defaultButtonForSexCategory
    }
    func obtainDefaultButtonForSortByRadioController(_ sortByRadioController: RadioButtonController) -> UIButton {
        guard let defaultButtonForSortByCategory = sortByRadioController.buttonsArray.first(where: { $0.currentTitle == "Ascending" }) else {
            return UIButton()
        }
        return defaultButtonForSortByCategory
    }
    func obtainDefaultButtonForPriceRangeRadioController(_ priceRangeController: RadioButtonController) -> UIButton {
        guard let defaultButtonForPriceRangeCategory = priceRangeController.buttonsArray.first(where: { $0.currentTitle == "Up to 3000₽" }) else {
            return UIButton()
        }
        return defaultButtonForPriceRangeCategory
    }
    func obtainDefaultButtonForCategoriesCheckBoxController(_ categoriesController: CheckBoxController) -> UIButton {
        guard let defaultButtonForCategories = categoriesController.buttonsArray.first(where: { $0.currentTitle == "Coats and jackets" }) else {
            return UIButton()
        }
        return defaultButtonForCategories
    }
    func obtainDefaultButtonForBrandsCheckBoxController(_ brandsController: CheckBoxController) -> UIButton {
        guard let defaultButtonForBrands = brandsController.buttonsArray.first(where: { $0.currentTitle == "Adidas" }) else {
            return UIButton()
        }
        return defaultButtonForBrands
    }
    func obtainDefaultButtonForSizesCheckBoxController(_ sizesController: CheckBoxController) -> UIButton {
        guard let defaultButtonForSizes = sizesController.buttonsArray.first(where: { $0.currentTitle == "41, 42, 43" }) else {
            return UIButton()
        }
        return defaultButtonForSizes
    }
    func obtainDefaultButtonForShopsCheckBoxController(_ shopsController: CheckBoxController) -> UIButton {
        guard let defaultButtonForShops = shopsController.buttonsArray.first(where: { $0.currentTitle == "Asos" }) else {
            return UIButton()
        }
        return defaultButtonForShops
    }
}

// MARK: - SearchBaseCoordinatedProtocol

extension SearchFilterPresenter: SearchBaseCoordinatedProtocol {}
