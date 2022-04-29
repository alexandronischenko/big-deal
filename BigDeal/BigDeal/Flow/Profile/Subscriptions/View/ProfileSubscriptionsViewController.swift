import UIKit

class ProfileSubscriptionsViewController: UIViewController {
    // MARK: - Private properties
    
    private let profileSubscriptionsView = ProfileSubscriptionsView()
    private var output: ProfileSubscriptionsPresenterOutputProtocol?
    private let brandsCheckBoxController = CheckBoxController()
    private let shopsCheckBoxController = CheckBoxController()
    
    // Reuse identifiers
    
    private let reuseIdForBrandsCheckBoxCell = CustomCheckBoxTableViewCell.customReuseIdForBrandsCheckBox
    private let reuseIdForShopsCheckBoxCell = CustomCheckBoxTableViewCell.customReuseIdForShopsCheckBox
    
    // MARK: - Initializers
    
    init(output: ProfileSubscriptionsPresenterOutputProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.output = output
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View life cycle
    
    override func loadView() {
        view = profileSubscriptionsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setUpProfileSubscriptionsTableView()
    }
    
    // MARK: - Private funcs
    
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
    
    private func setUpTitleForCheckBoxByIndexPath(_ indexPath: IndexPath, cell: CustomCheckBoxTableViewCell) {
        switch indexPath.section {
        case 0:
            setUpTitleForCheckBoxesInBrands(indexPath: indexPath, cell: cell)
        case 1:
            setUpTitleForCheckBoxesInShops(indexPath: indexPath, cell: cell)
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
    
    private func configureView() {
        title = "Subscriptions"
    }
    
    private func setUpProfileSubscriptionsTableView() {
        profileSubscriptionsView.profileSubscriptionsTableView.delegate = self
        profileSubscriptionsView.profileSubscriptionsTableView.dataSource = self
        profileSubscriptionsView.profileSubscriptionsTableView.register(CustomCheckBoxTableViewCell.self, forCellReuseIdentifier: reuseIdForBrandsCheckBoxCell)
        profileSubscriptionsView.profileSubscriptionsTableView.register(CustomCheckBoxTableViewCell.self, forCellReuseIdentifier: reuseIdForShopsCheckBoxCell)
    }
}

// MARK: - FeedMainPresenterInputProtocol

extension ProfileSubscriptionsViewController: ProfileSubscriptionsPresenterInputProtocol {
}

// MARK: - UITableViewDelegate

extension ProfileSubscriptionsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: .leastNormalMagnitude))
        let label = UILabel()
        label.frame = CGRect.init(x: 16, y: 15, width: headerView.frame.width - 32, height: headerView.frame.height - 30)
        switch section {
        case 0:
            label.text = "Brands"
        case 1:
            label.text = "Shops"
        default:
            label.text = ""
        }
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .label
        headerView.backgroundColor = .systemBackground
        headerView.addSubview(label)
        return headerView
    }
        
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
}

// MARK: - UITableViewDataSource

extension ProfileSubscriptionsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 4
        case 1:
            return 4
        default:
            return 1
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            return setUpBrandsCell(by: indexPath, tableView: tableView)
        case 1:
            return setUpShopsCell(by: indexPath, tableView: tableView)
        default:
            return UITableViewCell()
        }
    }
}
