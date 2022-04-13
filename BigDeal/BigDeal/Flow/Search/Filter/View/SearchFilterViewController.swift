import UIKit

class SearchFilterViewController: UIViewController {
    // MARK: - Private properties
    
    private var output: SearchFilterPresenterOutputProtocol?
    private let sexRadioButtonController = RadioButtonController()
    private let sortByRadioButtonController = RadioButtonController()
    private let priceRangeRadioButtonController = RadioButtonController()
    private let categoriesCheckBoxController = CheckBoxController()
    private let brandsCheckBoxController = CheckBoxController()
    private let sizesCheckBoxController = CheckBoxController()
    private let shopsCheckBoxController = CheckBoxController()
    private let searchFilterView = SearchFilterView()
    
    private let reuseIdForRadioButtonCell = CustomRadioButtonTableViewCell.customRadioButtonTableViewCellReuseId
    private let reuseIdForRadioButtonCell2 = "cell2"
    private let reuseIdForRadioButtonCell3 = "cell3"
    private let reuseIdForCheckBoxCell = CustomCheckBoxTableViewCell.customCheckBoxTableViewCellReuseId
    private let reuseIdForCategoryButtonCell = CustomCategoryButtonTableViewCell.customCategoryButtonTableViewCellReuseId
    private let reuseIdForHeaderView = CustomHeaderView.customHeaderViewReuseId
    
    private var isExpandedArray: [Bool] = []
    
    // MARK: - Initializers
    
    init(output: SearchFilterPresenterOutputProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.output = output
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
        isExpandedArray = [
            false, false, false, false, false, false, false
        ]
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        setUpDefaultButtonsForRadioControllers()
//    }
//
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        setUpDefaultButtonsForRadioControllers()
    }
    
    // MARK: - Private functions
    
    private func configureView() {
        title = "Filter"
    }
    
    private func setUpDefaultButtonsForRadioControllers() {
        guard let defaultButtonForSexCategory = sexRadioButtonController.buttonsArray.first(where: { $0.currentTitle == "Male" }) else {
            return
        }
        guard let defaultButtonForSortByCategory = sortByRadioButtonController.buttonsArray.first(where: { $0.currentTitle == "Ascending" }) else {
            return
        }
        guard let defaultButtonForPriceRangeCategory = priceRangeRadioButtonController.buttonsArray.first(where: { $0.currentTitle == "Up to 3000₽" }) else {
            return
        }
        sexRadioButtonController.defaultButtonForSexCategory = defaultButtonForSexCategory
        sortByRadioButtonController.defaultButtonForSortByCategory = defaultButtonForSortByCategory
        priceRangeRadioButtonController.defaultButtonForPriceRangeCategory = defaultButtonForPriceRangeCategory
    }
    
    private func setUpDefaultButtonsForCheckBoxController() {
        guard let defaultButtonForCategories = categoriesCheckBoxController.buttonsArray.first(where: { $0.currentTitle == "Coats and jackets" }) else {
            return
        }
        categoriesCheckBoxController.defaultButtonForShopsCategory = defaultButtonForCategories
    }
    
    private func setUpSearchFilterTableView() {
        searchFilterView.searchFilterTableView.delegate = self
        searchFilterView.searchFilterTableView.dataSource = self
        let radioButtonTableViewCellClass = CustomRadioButtonTableViewCell.self
        let categoryButtonTableViewCellClass = CustomCategoryButtonTableViewCell.self
        let headerFooterViewClass = CustomHeaderView.self
        let checkBoxTableViewCellClass = CustomCheckBoxTableViewCell.self
        searchFilterView.searchFilterTableView.register(radioButtonTableViewCellClass, forCellReuseIdentifier: reuseIdForRadioButtonCell2)
        searchFilterView.searchFilterTableView.register(radioButtonTableViewCellClass, forCellReuseIdentifier: reuseIdForRadioButtonCell3)
        searchFilterView.searchFilterTableView.register(radioButtonTableViewCellClass, forCellReuseIdentifier: reuseIdForRadioButtonCell)
        searchFilterView.searchFilterTableView.register(categoryButtonTableViewCellClass, forCellReuseIdentifier: CustomCategoryButtonTableViewCell.customCategoryButtonTableViewCellReuseId)
        searchFilterView.searchFilterTableView.register(checkBoxTableViewCellClass, forCellReuseIdentifier: reuseIdForCheckBoxCell)
        searchFilterView.searchFilterTableView.register(headerFooterViewClass, forHeaderFooterViewReuseIdentifier: reuseIdForHeaderView)
        searchFilterView.searchFilterTableView.tableFooterView = UIView()
    }
    
    private func setUpCategoriesSection(by indexPath: IndexPath, checkBoxCell: CustomCheckBoxTableViewCell) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            checkBoxCell.configureCell(with: "Coats and jackets")
            categoriesCheckBoxController.addButtonToCheckBoxController(checkBoxCell.checkBoxButton)
            return checkBoxCell
        case 1:
            checkBoxCell.configureCell(with: "Sweats")
            brandsCheckBoxController.addButtonToCheckBoxController(checkBoxCell.checkBoxButton)
            return checkBoxCell
        case 2:
            checkBoxCell.configureCell(with: "T-shirts")
            sizesCheckBoxController.addButtonToCheckBoxController(checkBoxCell.checkBoxButton)
            return checkBoxCell
        case 3:
            checkBoxCell.configureCell(with: "Sneakers")
            shopsCheckBoxController.addButtonToCheckBoxController(checkBoxCell.checkBoxButton)
            return checkBoxCell
        case 4:
            checkBoxCell.configureCell(with: "Parfum")
            shopsCheckBoxController.addButtonToCheckBoxController(checkBoxCell.checkBoxButton)
            return checkBoxCell
        default:
            return UITableViewCell()
        }
    }
    
    private func setUpExpCellsBy(indexPath: IndexPath, checkBoxCell: CustomCheckBoxTableViewCell) -> UITableViewCell {
        switch indexPath.section {
        case 3:
            return setUpCategoriesSection(by: indexPath, checkBoxCell: checkBoxCell)
        case 4:
            switch indexPath.row {
            case 0:
                checkBoxCell.configureCell(with: "Adidas")
                categoriesCheckBoxController.addButtonToCheckBoxController(checkBoxCell.checkBoxButton)
                return checkBoxCell
            case 1:
                checkBoxCell.configureCell(with: "Nike")
                brandsCheckBoxController.addButtonToCheckBoxController(checkBoxCell.checkBoxButton)
                return checkBoxCell
            case 2:
                checkBoxCell.configureCell(with: "Reebok")
                sizesCheckBoxController.addButtonToCheckBoxController(checkBoxCell.checkBoxButton)
                return checkBoxCell
            case 3:
                checkBoxCell.configureCell(with: "New Balance")
                shopsCheckBoxController.addButtonToCheckBoxController(checkBoxCell.checkBoxButton)
                return checkBoxCell
            default:
                return UITableViewCell()
            }
        case 5:
            switch indexPath.row {
            case 0:
                checkBoxCell.configureCell(with: "41")
                categoriesCheckBoxController.addButtonToCheckBoxController(checkBoxCell.checkBoxButton)
                return checkBoxCell
            case 1:
                checkBoxCell.configureCell(with: "42")
                brandsCheckBoxController.addButtonToCheckBoxController(checkBoxCell.checkBoxButton)
                return checkBoxCell
            case 2:
                checkBoxCell.configureCell(with: "43")
                sizesCheckBoxController.addButtonToCheckBoxController(checkBoxCell.checkBoxButton)
                return checkBoxCell
            default:
                return UITableViewCell()
            }
        case 6:
            switch indexPath.row {
            case 0:
                checkBoxCell.configureCell(with: "Asos")
                categoriesCheckBoxController.addButtonToCheckBoxController(checkBoxCell.checkBoxButton)
                return checkBoxCell
            case 1:
                checkBoxCell.configureCell(with: "Stock-X")
                brandsCheckBoxController.addButtonToCheckBoxController(checkBoxCell.checkBoxButton)
                return checkBoxCell
            case 2:
                checkBoxCell.configureCell(with: "Ozon")
                sizesCheckBoxController.addButtonToCheckBoxController(checkBoxCell.checkBoxButton)
                return checkBoxCell
            case 3:
                checkBoxCell.configureCell(with: "NB")
                shopsCheckBoxController.addButtonToCheckBoxController(checkBoxCell.checkBoxButton)
                return checkBoxCell
            default:
                return UITableViewCell()
            }
        default:
            return UITableViewCell()
        }
    }
    
    private func setUpTitleForCategoryButtonByIndexPath(_ indexPath: IndexPath, cell: CustomCategoryButtonTableViewCell) {
        switch indexPath.section {
        case 3:
            cell.configureButton(with: "Category")
        case 4:
            cell.configureButton(with: "Brand")
        case 5:
            cell.configureButton(with: "Size")
        case 6:
            cell.configureButton(with: "Shop")
        default:
            break
        }
    }
    private func setUpTitleForRadioButtonByIndexPath(_ indexPath: IndexPath, cell: CustomRadioButtonTableViewCell) {
        switch indexPath.section {
        case 0:
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
        case 1:
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
        case 2:
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
        default:
            break
        }
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
            label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
            label.textColor = .label
            headerView.backgroundColor = .systemBackground
            headerView.addSubview(label)
            return headerView
        case 3...6:
            guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: reuseIdForHeaderView) as? CustomHeaderView else {
                return UITableViewHeaderFooterView()
            }
            headerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: .leastNormalMagnitude)
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
            headerView.delegate = self
            headerView.sizeToFit()
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
        if !isExpandedArray[section] {
            switch section {
            case 0:
                return 3
            case 1:
                return 3
            case 2:
                return 4
            case 3...6:
                return 0
            default:
                return 0
            }
        } else {
            switch section {
            case 3:
                return 5
            case 4:
                return 4
            case 5:
                return 3
            case 6:
                return 4
            default:
                return 4
            }
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
                guard let radioButtonCell = tableView.dequeueReusableCell(withIdentifier: reuseIdForRadioButtonCell, for: indexPath) as? CustomRadioButtonTableViewCell else {
                    return UITableViewCell()
                }
                setUpTitleForRadioButtonByIndexPath(indexPath, cell: radioButtonCell)
                sexRadioButtonController.addButtonForRadioController(radioButtonCell.radioButton)
                guard let defaultButton = output?.obtainDefaultButtonForSexRadioController(sexRadioButtonController) else {
                    return UITableViewCell()
                }
                sexRadioButtonController.defaultButtonForSexCategory = defaultButton
                radioButtonCell.prepareForReuse()
                return radioButtonCell
        case 1:
            guard let radioButtonCell = tableView.dequeueReusableCell(withIdentifier: reuseIdForRadioButtonCell2, for: indexPath) as? CustomRadioButtonTableViewCell else {
                return UITableViewCell()
            }
                setUpTitleForRadioButtonByIndexPath(indexPath, cell: radioButtonCell)
                sortByRadioButtonController.addButtonForRadioController(radioButtonCell.radioButton)
                guard let defaultButton = output?.obtainDefaultButtonForSortByRadioController(sortByRadioButtonController) else {
                    return UITableViewCell()
                }
                sortByRadioButtonController.defaultButtonForSexCategory = defaultButton
                radioButtonCell.prepareForReuse()
                return radioButtonCell
        case 2:
            guard let radioButtonCell = tableView.dequeueReusableCell(withIdentifier: reuseIdForRadioButtonCell3, for: indexPath) as? CustomRadioButtonTableViewCell else {
                return UITableViewCell()
            }
                radioButtonCell.prepareForReuse()
                setUpTitleForRadioButtonByIndexPath(indexPath, cell: radioButtonCell)
                priceRangeRadioButtonController.addButtonForRadioController(radioButtonCell.radioButton)
                guard let defaultButton = output?.obtainDefaultButtonForPriceRangeRadioController(priceRangeRadioButtonController) else {
                    return UITableViewCell()
                }
                priceRangeRadioButtonController.defaultButtonForSexCategory = defaultButton
                radioButtonCell.prepareForReuse()
                return radioButtonCell
        case 3...6:
            guard let checkBoxCell = tableView.dequeueReusableCell(withIdentifier: reuseIdForCheckBoxCell, for: indexPath) as? CustomCheckBoxTableViewCell else {
                return UITableViewCell()
            }
            return setUpExpCellsBy(indexPath: indexPath, checkBoxCell: checkBoxCell)
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
