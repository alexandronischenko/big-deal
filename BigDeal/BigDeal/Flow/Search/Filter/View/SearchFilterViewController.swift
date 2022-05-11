import UIKit

class SearchFilterViewController: UIViewController {
    // MARK: - Private properties
    
    // Dependencies
    
    private var output: SearchFilterPresenterOutputProtocol?
    private let searchFilterView = SearchFilterView()
    
    // Common
    
    private let sexRadioButtonController = RadioButtonController()
    private let sortByRadioButtonController = RadioButtonController()
    private let priceRangeRadioButtonController = RadioButtonController()
    
    private let categoriesCheckBoxController = CheckBoxController()
    private let brandsCheckBoxController = CheckBoxController()
    private let sizesCheckBoxController = CheckBoxController()
    private let shopsCheckBoxController = CheckBoxController()
    
    // Reuse Identifiers
    
    private let reuseIdForSexRadioButtonCell = CustomRadioButtonTableViewCell.customReuseIdForSexCategory
    private let reuseIdForSortByRadioButtonCell = CustomRadioButtonTableViewCell.customReuseIdForSortByCategory
    private let reuseIdForPriceRangeRadioButtonCell = CustomRadioButtonTableViewCell.customReuseIdForPriceRangeCategory
    
    private let reuseIdForCategoriesCheckBoxCell = CustomCheckBoxTableViewCell.customReuseIdForCategoriesCheckBox
    private let reuseIdForBrandsCheckBoxCell = CustomCheckBoxTableViewCell.customReuseIdForBrandsCheckBox
    private let reuseIdForSizesCheckBoxCell = CustomCheckBoxTableViewCell.customReuseIdForSizesCheckBox
    private let reuseIdForShopsCheckBoxCell = CustomCheckBoxTableViewCell.customReuseIdForShopsCheckBox
    
    private let reuseIdForCategoriesHeaderView = CustomHeaderView.customCategoriesHeaderViewReuseId
    private let reuseIdForBrandsHeaderView = CustomHeaderView.customBrandsHeaderViewReuseId
    private let reuseIdForSizesHeaderView = CustomHeaderView.customSizesHeaderViewReuseId
    private let reuseIdForShopsHeaderView = CustomHeaderView.customShopsHeaderViewReuseId
    
    // Data
    
    private var isExpandedArray: [Bool] = DataManager.shared.isExpandedArray
    
    // MARK: - Initializers
    
    init(output: SearchFilterPresenterOutputProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.output = output
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View life cycle
    
    override func loadView() {
        view = searchFilterView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchFilterView.delegate = self
        configureView()
        setUpSearchFilterTableView()
    }
    
    // MARK: - Private functions
    
    private func configureView() {
        title = "Filter"
    }
    private func setUpSearchFilterTableView() {
        let radioButtonTableViewCellClass = CustomRadioButtonTableViewCell.self
        let headerFooterViewClass = CustomHeaderView.self
        let checkBoxTableViewCellClass = CustomCheckBoxTableViewCell.self
        
        searchFilterView.searchFilterTableView.delegate = self
        searchFilterView.searchFilterTableView.dataSource = self
        
        searchFilterView.searchFilterTableView.register(radioButtonTableViewCellClass, forCellReuseIdentifier: reuseIdForSexRadioButtonCell)
        searchFilterView.searchFilterTableView.register(radioButtonTableViewCellClass, forCellReuseIdentifier: reuseIdForSortByRadioButtonCell)
        searchFilterView.searchFilterTableView.register(radioButtonTableViewCellClass, forCellReuseIdentifier: reuseIdForPriceRangeRadioButtonCell)
        
        searchFilterView.searchFilterTableView.register(checkBoxTableViewCellClass, forCellReuseIdentifier: reuseIdForCategoriesCheckBoxCell)
        searchFilterView.searchFilterTableView.register(checkBoxTableViewCellClass, forCellReuseIdentifier: reuseIdForBrandsCheckBoxCell)
        searchFilterView.searchFilterTableView.register(checkBoxTableViewCellClass, forCellReuseIdentifier: reuseIdForSizesCheckBoxCell)
        searchFilterView.searchFilterTableView.register(checkBoxTableViewCellClass, forCellReuseIdentifier: reuseIdForShopsCheckBoxCell)
        
        searchFilterView.searchFilterTableView.register(headerFooterViewClass, forHeaderFooterViewReuseIdentifier: reuseIdForCategoriesHeaderView)
        searchFilterView.searchFilterTableView.register(headerFooterViewClass, forHeaderFooterViewReuseIdentifier: reuseIdForBrandsHeaderView)
        searchFilterView.searchFilterTableView.register(headerFooterViewClass, forHeaderFooterViewReuseIdentifier: reuseIdForSizesHeaderView)
        searchFilterView.searchFilterTableView.register(headerFooterViewClass, forHeaderFooterViewReuseIdentifier: reuseIdForShopsHeaderView)
    }
    private func obtainNumberOfRowsInSection(section: Int) -> Int {
        if !isExpandedArray[section] {
            switch section {
            case 0, 1:
                return 3
            case 2:
                return 4
            default:
                return 0
            }
        } else {
            switch section {
            case 3:
                return 5
            case 4, 6:
                return 4
            case 5:
                return 3
            default:
                return 0
            }
        }
    }
    private func setUpTitleForRadioButtonByIndexPath(_ indexPath: IndexPath, cell: CustomRadioButtonTableViewCell) {
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
    private func setUpTitleForRadioButtonsInSexCategory(indexPath: IndexPath, cell: CustomRadioButtonTableViewCell) {
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
    private func setUpTitleForRadioButtonsInSortByCategory(indexPath: IndexPath, cell: CustomRadioButtonTableViewCell) {
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
    private func setUpTitleForRadioButtonsInPriceRangeCategory(indexPath: IndexPath, cell: CustomRadioButtonTableViewCell) {
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
    private func setUpTitleForCheckBoxByIndexPath(_ indexPath: IndexPath, cell: CustomCheckBoxTableViewCell) {
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
    private func setUpTitleForCheckBoxesInCategories(indexPath: IndexPath, cell: CustomCheckBoxTableViewCell) {
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
    private func setUpTitleForCheckBoxesInBrands(indexPath: IndexPath, cell: CustomCheckBoxTableViewCell) {
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
    private func setUpTitleForCheckBoxesInSizes(indexPath: IndexPath, cell: CustomCheckBoxTableViewCell) {
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
    private func setUpTitleForCheckBoxesInShops(indexPath: IndexPath, cell: CustomCheckBoxTableViewCell) {
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
    private func configureHeaderViewBySection(headerView: CustomHeaderView, section: Int) {
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
    private func obtainTextForHeaderViewLabelBySection(section: Int, label: UILabel) {
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
    private func setUpSexCategoryCells(by indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
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
    private func setUpSortByCategoryCells(by indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
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
    private func setUpPriceRangeCategoryCells(by indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
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
    private func setUpCategoriesCell(by indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
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
    private func setUpBrandsCell(by indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
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
    private func setUpSizesCell(by indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
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
    private func setUpShopsCell(by indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
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

// MARK: - SearchFilterPresenterInputProtocol

extension SearchFilterViewController: SearchFilterPresenterInputProtocol {}

// MARK: - UITableViewDelegate

extension SearchFilterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0...2:
            let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: .leastNormalMagnitude))
            let label = UILabel()
            label.frame = CGRect.init(x: 16, y: 15, width: headerView.frame.width - 32, height: headerView.frame.height - 30)
            label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
            label.textColor = .label
            obtainTextForHeaderViewLabelBySection(section: section, label: label)
            headerView.backgroundColor = .systemBackground
            headerView.addSubview(label)
            return headerView
        case 3:
            guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: reuseIdForCategoriesHeaderView) as? CustomHeaderView else {
                return UITableViewHeaderFooterView()
            }
            headerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: .leastNormalMagnitude)
            configureHeaderViewBySection(headerView: headerView, section: section)
            headerView.delegate = self
            return headerView
        case 4:
            guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: reuseIdForBrandsHeaderView) as? CustomHeaderView else {
                return UITableViewHeaderFooterView()
            }
            headerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: .leastNormalMagnitude)
            configureHeaderViewBySection(headerView: headerView, section: section)
            headerView.delegate = self
            return headerView
        case 5:
            guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: reuseIdForSizesHeaderView) as? CustomHeaderView else {
                return UITableViewHeaderFooterView()
            }
            headerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: .leastNormalMagnitude)
            configureHeaderViewBySection(headerView: headerView, section: section)
            headerView.delegate = self
            return headerView
        case 6:
            guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: reuseIdForShopsHeaderView) as? CustomHeaderView else {
                return UITableViewHeaderFooterView()
            }
            headerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: .leastNormalMagnitude)
            configureHeaderViewBySection(headerView: headerView, section: section)
            headerView.delegate = self
            return headerView
        default:
            return UITableViewHeaderFooterView()
        }
    }
        
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0...2:
            return 20
        case 3...6:
            return 30
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 3...6:
            return 40
        default:
            return UITableView.automaticDimension
        }
    }
}

// MARK: - UITableViewDataSource

extension SearchFilterViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return isExpandedArray.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        obtainNumberOfRowsInSection(section: section)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            return setUpSexCategoryCells(by: indexPath, tableView: tableView)
        case 1:
            return setUpSortByCategoryCells(by: indexPath, tableView: tableView)
        case 2:
            return setUpPriceRangeCategoryCells(by: indexPath, tableView: tableView)
        case 3:
            return setUpCategoriesCell(by: indexPath, tableView: tableView)
        case 4:
            return setUpBrandsCell(by: indexPath, tableView: tableView)
        case 5:
            return setUpSizesCell(by: indexPath, tableView: tableView)
        case 6:
            return setUpShopsCell(by: indexPath, tableView: tableView)
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - SearchFilterViewDelegate

extension SearchFilterViewController: SearchFilterViewDelegate {
    func dismissFilterView() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - CustomHeaderViewDelegate

extension SearchFilterViewController: CustomHeaderViewDelegate {
    func expandedSection(button: UIButton) {
        let section = button.tag
        let isExpanded = isExpandedArray[section]
        isExpandedArray[section] = !isExpanded
        self.searchFilterView.searchFilterTableView.reloadSections(IndexSet(integer: section), with: .none)
    }
}
