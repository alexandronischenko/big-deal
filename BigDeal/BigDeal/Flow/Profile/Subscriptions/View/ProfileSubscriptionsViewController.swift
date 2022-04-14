import UIKit

class ProfileSubscriptionsViewController: UIViewController {
    // MARK: - Private properties
    
    private let profileSubscriptionsView = ProfileSubscriptionsView()
    private var output: ProfileSubscriptionsPresenterOutputProtocol?
    private let brandsCheckBoxController = CheckBoxController()
    private let shopsCheckBoxController = CheckBoxController()
    
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
    
    private func configureView() {
        title = "Subscriptions"
    }
    
    private func setUpProfileSubscriptionsTableView() {
        profileSubscriptionsView.profileSubscriptionsTableView.delegate = self
        profileSubscriptionsView.profileSubscriptionsTableView.dataSource = self
        profileSubscriptionsView.profileSubscriptionsTableView.register(CustomCheckBoxTableViewCell.self, forCellReuseIdentifier: CustomCheckBoxTableViewCell.customReuseIdForCategoriesCheckBox)
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
        guard let tableViewCell = tableView.dequeueReusableCell(withIdentifier: CustomCheckBoxTableViewCell.customReuseIdForCategoriesCheckBox) as? CustomCheckBoxTableViewCell else {
            return UITableViewCell()
        }
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0...3:
                switch indexPath.row {
                case 0:
                    tableViewCell.configureCell(with: "Adidas")
                case 1:
                    tableViewCell.configureCell(with: "Nike")
                case 2:
                    tableViewCell.configureCell(with: "Reebok")
                case 3:
                    tableViewCell.configureCell(with: "New Balance")
                default:
                    break
                }
                brandsCheckBoxController.addButtonToCheckBoxController(tableViewCell.checkBoxButton)
                return tableViewCell
            default:
                return UITableViewCell()
            }
        case 1:
            switch indexPath.row {
            case 0...3:
                switch indexPath.row {
                case 0:
                    tableViewCell.configureCell(with: "ASOS")
                case 1:
                    tableViewCell.configureCell(with: "StockX")
                case 2:
                    tableViewCell.configureCell(with: "Ozon")
                case 3:
                    tableViewCell.configureCell(with: "New Balance")
                default:
                    break
                }
                shopsCheckBoxController.addButtonToCheckBoxController(tableViewCell.checkBoxButton)
                return tableViewCell
            default:
                return UITableViewCell()
            }
        default:
            return UITableViewCell()
        }
    }
}
