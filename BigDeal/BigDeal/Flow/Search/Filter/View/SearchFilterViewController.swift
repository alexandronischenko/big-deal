import UIKit

class SearchFilterViewController: UIViewController {
    // MARK: - Private properties
    
    // Dependencies
    
    var output: SearchFilterPresenterOutputProtocol?
    private let searchFilterView = SearchFilterView()
    // Common
    
    let sexRadioButtonController = RadioButtonController()
    let sortByRadioButtonController = RadioButtonController()
    let priceRangeRadioButtonController = RadioButtonController()
    
    let categoriesCheckBoxController = CheckBoxController()
    let brandsCheckBoxController = CheckBoxController()
    let sizesCheckBoxController = CheckBoxController()
    let shopsCheckBoxController = CheckBoxController()
    // Reuse Identifiers
    
    let reuseIdForSexRadioButtonCell = CustomRadioButtonTableViewCell.customReuseIdForSexCategory
    let reuseIdForSortByRadioButtonCell = CustomRadioButtonTableViewCell.customReuseIdForSortByCategory
    let reuseIdForPriceRangeRadioButtonCell = CustomRadioButtonTableViewCell.customReuseIdForPriceRangeCategory
    let reuseIdForCategoriesCheckBoxCell = CustomCheckBoxTableViewCell.customReuseIdForCategoriesCheckBox
    let reuseIdForBrandsCheckBoxCell = CustomCheckBoxTableViewCell.customReuseIdForBrandsCheckBox
    let reuseIdForSizesCheckBoxCell = CustomCheckBoxTableViewCell.customReuseIdForSizesCheckBox
    let reuseIdForShopsCheckBoxCell = CustomCheckBoxTableViewCell.customReuseIdForShopsCheckBox
    let reuseIdForCategoriesHeaderView = CustomHeaderView.customCategoriesHeaderViewReuseId
    let reuseIdForBrandsHeaderView = CustomHeaderView.customBrandsHeaderViewReuseId
    let reuseIdForSizesHeaderView = CustomHeaderView.customSizesHeaderViewReuseId
    let reuseIdForShopsHeaderView = CustomHeaderView.customShopsHeaderViewReuseId
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
        searchFilterView.searchFilterTableView.delegate = self
        searchFilterView.searchFilterTableView.dataSource = self
        
        searchFilterView.searchFilterTableView.register(CustomRadioButtonTableViewCell.self, forCellReuseIdentifier: reuseIdForSexRadioButtonCell)
        searchFilterView.searchFilterTableView.register(CustomRadioButtonTableViewCell.self, forCellReuseIdentifier: reuseIdForSortByRadioButtonCell)
        searchFilterView.searchFilterTableView.register(CustomRadioButtonTableViewCell.self, forCellReuseIdentifier: reuseIdForPriceRangeRadioButtonCell)
        
        searchFilterView.searchFilterTableView.register(CustomCheckBoxTableViewCell.self, forCellReuseIdentifier: reuseIdForCategoriesCheckBoxCell)
        searchFilterView.searchFilterTableView.register(CustomCheckBoxTableViewCell.self, forCellReuseIdentifier: reuseIdForBrandsCheckBoxCell)
        searchFilterView.searchFilterTableView.register(CustomCheckBoxTableViewCell.self, forCellReuseIdentifier: reuseIdForSizesCheckBoxCell)
        searchFilterView.searchFilterTableView.register(CustomCheckBoxTableViewCell.self, forCellReuseIdentifier: reuseIdForShopsCheckBoxCell)
        
        searchFilterView.searchFilterTableView.register(CustomHeaderView.self, forHeaderFooterViewReuseIdentifier: reuseIdForCategoriesHeaderView)
        searchFilterView.searchFilterTableView.register(CustomHeaderView.self, forHeaderFooterViewReuseIdentifier: reuseIdForBrandsHeaderView)
        searchFilterView.searchFilterTableView.register(CustomHeaderView.self, forHeaderFooterViewReuseIdentifier: reuseIdForSizesHeaderView)
        searchFilterView.searchFilterTableView.register(CustomHeaderView.self, forHeaderFooterViewReuseIdentifier: reuseIdForShopsHeaderView)
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
}
// MARK: - SearchFilterPresenterInputProtocol

extension SearchFilterViewController: SearchFilterPresenterInputProtocol {
}
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
        let userDefaults = UserDefaults.standard
        switch sortByRadioButtonController.selectedButtons.first?.currentTitle {
        case "Ascending":
            userDefaults.set("priceasc", forKey: "sortBy")
        case "Descending":
            userDefaults.set("pricedesc", forKey: "sortBy")
        default:
            userDefaults.set("freshness", forKey: "sortBy")
        }
        switch priceRangeRadioButtonController.selectedButtons.first?.currentTitle {
        case "Up to 3000₽":
            userDefaults.set("0", forKey: "priceMin")
            userDefaults.set("50", forKey: "priceMax")
        case "3000 - 7000₽":
            userDefaults.set("50", forKey: "priceMin")
            userDefaults.set("100", forKey: "priceMax")
        case "7000 - 15000₽":
            userDefaults.set("100", forKey: "priceMin")
            userDefaults.set("200", forKey: "priceMax")
        default:
            userDefaults.set("200", forKey: "priceMin")
            userDefaults.set("", forKey: "priceMax")
        }
        userDefaults.set(true, forKey: "isSearchByFilters")
        output?.closeFilterAndLoadData()
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
