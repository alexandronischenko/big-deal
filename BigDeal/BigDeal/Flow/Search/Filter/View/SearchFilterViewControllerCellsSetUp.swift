import Foundation
import UIKit

extension SearchFilterViewController {
    func setUpSexCategoryCells(by indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        guard let radioButtonCell = tableView.dequeueReusableCell(withIdentifier: reuseIdForSexRadioButtonCell, for: indexPath) as? CustomRadioButtonTableViewCell else {
            return UITableViewCell()
        }
        setUpTitleForRadioButtonByIndexPath(indexPath, cell: radioButtonCell)
        sexRadioButtonController.addButtonForRadioController(radioButtonCell.radioButton)
        guard let defaultButton = output?.obtainDefaultButtonForSexRadioController(sexRadioButtonController) else {
            return UITableViewCell()
        }
        sexRadioButtonController.defaultButton = defaultButton
        return radioButtonCell
    }
    
    func setUpSortByCategoryCells(by indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        guard let radioButtonCell = tableView.dequeueReusableCell(withIdentifier: reuseIdForSortByRadioButtonCell, for: indexPath) as? CustomRadioButtonTableViewCell else {
            return UITableViewCell()
        }
        setUpTitleForRadioButtonByIndexPath(indexPath, cell: radioButtonCell)
        sortByRadioButtonController.addButtonForRadioController(radioButtonCell.radioButton)
        guard let defaultButton = output?.obtainDefaultButtonForSortByRadioController(sortByRadioButtonController) else {
            return UITableViewCell()
        }
        sortByRadioButtonController.defaultButton = defaultButton
        return radioButtonCell
    }
    
    func setUpPriceRangeCategoryCells(by indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        guard let radioButtonCell = tableView.dequeueReusableCell(withIdentifier: reuseIdForPriceRangeRadioButtonCell, for: indexPath) as? CustomRadioButtonTableViewCell else {
            return UITableViewCell()
        }
        setUpTitleForRadioButtonByIndexPath(indexPath, cell: radioButtonCell)
        priceRangeRadioButtonController.addButtonForRadioController(radioButtonCell.radioButton)
        guard let defaultButton = output?.obtainDefaultButtonForPriceRangeRadioController(priceRangeRadioButtonController) else {
            return UITableViewCell()
        }
        priceRangeRadioButtonController.defaultButton = defaultButton
        return radioButtonCell
    }
    
    func setUpCategoriesCell(by indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        guard let checkBoxCell = tableView.dequeueReusableCell(withIdentifier: reuseIdForCategoriesCheckBoxCell, for: indexPath) as? CustomCheckBoxTableViewCell else {
            return UITableViewCell()
        }
        setUpTitleForCheckBoxByIndexPath(indexPath, cell: checkBoxCell)
        categoriesCheckBoxController.addButtonToCheckBoxController(checkBoxCell.checkBoxButton)
        guard let defaultButton = output?.obtainDefaultButtonForCategoriesCheckBoxController(categoriesCheckBoxController) else {
            return UITableViewCell()
        }
        categoriesCheckBoxController.defaultButton = defaultButton
        categoriesCheckBoxController.defaultButton.isSelected = true
        return checkBoxCell
    }
    
    func setUpBrandsCell(by indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        guard let checkBoxCell = tableView.dequeueReusableCell(withIdentifier: reuseIdForBrandsCheckBoxCell, for: indexPath) as? CustomCheckBoxTableViewCell else {
            return UITableViewCell()
        }
        setUpTitleForCheckBoxByIndexPath(indexPath, cell: checkBoxCell)
        brandsCheckBoxController.addButtonToCheckBoxController(checkBoxCell.checkBoxButton)
        guard let defaultButton = output?.obtainDefaultButtonForBrandsCheckBoxController(brandsCheckBoxController) else {
            return UITableViewCell()
        }
        brandsCheckBoxController.defaultButton = defaultButton
        brandsCheckBoxController.defaultButton.isSelected = true
        return checkBoxCell
    }
    
    func setUpSizesCell(by indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        guard let checkBoxCell = tableView.dequeueReusableCell(withIdentifier: reuseIdForSizesCheckBoxCell, for: indexPath) as? CustomCheckBoxTableViewCell else {
            return UITableViewCell()
        }
        setUpTitleForCheckBoxByIndexPath(indexPath, cell: checkBoxCell)
        sizesCheckBoxController.addButtonToCheckBoxController(checkBoxCell.checkBoxButton)
        guard let defaultButton = output?.obtainDefaultButtonForSizesCheckBoxController(sizesCheckBoxController) else {
            return UITableViewCell()
        }
        sizesCheckBoxController.defaultButton = defaultButton
        sizesCheckBoxController.defaultButton.isSelected = true
        return checkBoxCell
    }
    
    func setUpShopsCell(by indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        guard let checkBoxCell = tableView.dequeueReusableCell(withIdentifier: reuseIdForShopsCheckBoxCell, for: indexPath) as? CustomCheckBoxTableViewCell else {
            return UITableViewCell()
        }
        setUpTitleForCheckBoxByIndexPath(indexPath, cell: checkBoxCell)
        shopsCheckBoxController.addButtonToCheckBoxController(checkBoxCell.checkBoxButton)
        guard let defaultButton = output?.obtainDefaultButtonForShopsCheckBoxController(shopsCheckBoxController) else {
            return UITableViewCell()
        }
        shopsCheckBoxController.defaultButton = defaultButton
        shopsCheckBoxController.defaultButton.isSelected = true
        return checkBoxCell
    }
}
