import Foundation
import UIKit

extension SearchFilterViewController {
    func setUpTitleForRadioButtonByIndexPath(_ indexPath: IndexPath, cell: CustomRadioButtonTableViewCell) {
        switch indexPath.section {
        case 0:
            setUpTitleForRadioButtonsInSexCategory(indexPath: indexPath, cell: cell)
        case 1:
            setUpTitleForRadioButtonsInSortByCategory(indexPath: indexPath, cell: cell)
        case 2:
            setUpTitleForRadioButtonsInPriceRangeCategory(indexPath: indexPath, cell: cell)
        default:
            break
        }
    }
    
    func setUpTitleForRadioButtonsInSexCategory(indexPath: IndexPath, cell: CustomRadioButtonTableViewCell) {
        switch indexPath.row {
        case 0:
            cell.configureCell(with: "Male")
        case 1:
            cell.configureCell(with: "Female")
        case 2:
            cell.configureCell(with: "Unisex")
        default:
            break
        }
    }
    
    func setUpTitleForRadioButtonsInSortByCategory(indexPath: IndexPath, cell: CustomRadioButtonTableViewCell) {
        switch indexPath.row {
        case 0:
            cell.configureCell(with: "Ascending")
        case 1:
            cell.configureCell(with: "Descending")
        case 2:
            cell.configureCell(with: "Most profitable")
        default:
            break
        }
    }
    
    func setUpTitleForRadioButtonsInPriceRangeCategory(indexPath: IndexPath, cell: CustomRadioButtonTableViewCell) {
        switch indexPath.row {
        case 0:
            cell.configureCell(with: "Up to 3000₽")
        case 1:
            cell.configureCell(with: "3000 - 7000₽")
        case 2:
            cell.configureCell(with: "7000 - 15000₽")
        case 3:
            cell.configureCell(with: "15000₽ +")
        default:
            break
        }
    }
    
    func setUpTitleForCheckBoxByIndexPath(_ indexPath: IndexPath, cell: CustomCheckBoxTableViewCell) {
        switch indexPath.section {
        case 3:
            setUpTitleForCheckBoxesInCategories(indexPath: indexPath, cell: cell)
        case 4:
            setUpTitleForCheckBoxesInBrands(indexPath: indexPath, cell: cell)
        case 5:
            setUpTitleForCheckBoxesInSizes(indexPath: indexPath, cell: cell)
        case 6:
            setUpTitleForCheckBoxesInShops(indexPath: indexPath, cell: cell)
        default:
            break
        }
    }
    
    func setUpTitleForCheckBoxesInCategories(indexPath: IndexPath, cell: CustomCheckBoxTableViewCell) {
        switch indexPath.row {
        case 0:
            cell.configureCell(with: "Coats and jackets")
        case 1:
            cell.configureCell(with: "Sweats")
        case 2:
            cell.configureCell(with: "T-shirts")
        case 3:
            cell.configureCell(with: "Sneakers")
        case 4:
            cell.configureCell(with: "Parfum")
        default:
            break
        }
    }
    
    func setUpTitleForCheckBoxesInBrands(indexPath: IndexPath, cell: CustomCheckBoxTableViewCell) {
        switch indexPath.row {
        case 0:
            cell.configureCell(with: "Adidas")
        case 1:
            cell.configureCell(with: "Nike")
        case 2:
            cell.configureCell(with: "Reebok")
        case 3:
            cell.configureCell(with: "New Balance")
        default:
            break
        }
    }
    
    func setUpTitleForCheckBoxesInSizes(indexPath: IndexPath, cell: CustomCheckBoxTableViewCell) {
        switch indexPath.row {
        case 0:
            cell.configureCell(with: "41")
        case 1:
            cell.configureCell(with: "42")
        case 2:
            cell.configureCell(with: "43")
        default:
            break
        }
    }
    
    func setUpTitleForCheckBoxesInShops(indexPath: IndexPath, cell: CustomCheckBoxTableViewCell) {
        switch indexPath.row {
        case 0:
            cell.configureCell(with: "Asos")
        case 1:
            cell.configureCell(with: "Stock-X")
        case 2:
            cell.configureCell(with: "Ozon")
        case 3:
            cell.configureCell(with: "NB")
        default:
            break
        }
    }
    
    func configureHeaderViewBySection(headerView: CustomHeaderView, section: Int) {
        switch section {
        case 3:
            headerView.configure(title: "Categories", section: section)
        case 4:
            headerView.configure(title: "Brands", section: section)
        case 5:
            headerView.configure(title: "Sizes", section: section)
        case 6:
            headerView.configure(title: "Shops", section: section)
        default:
            break
        }
    }
    
    func obtainTextForHeaderViewLabelBySection(section: Int, label: UILabel) {
        switch section {
        case 0:
            label.text = "Sex"
        case 1:
            label.text = "Sort by"
        case 2:
            label.text = "Price range"
        default:
            label.text = nil
        }
    }
}
