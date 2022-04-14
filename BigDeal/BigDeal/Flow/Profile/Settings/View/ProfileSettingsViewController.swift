import UIKit

class ProfileSettingsViewController: UIViewController, UITextFieldDelegate {
    // MARK: - Private properties
    
    private var output: ProfileSettingsPresenterOutputProtocol?
    private let profileSettingsView = ProfileSettingsView()
    private let sexRadioButtonController = RadioButtonController()
    
    // MARK: - Initializers
    
    init(output: ProfileSettingsPresenterOutputProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.output = output
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View life cycle
    
    override func loadView() {
        view = profileSettingsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setUpProfileSettingsTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpDefaultButtonsForRadioControllers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setUpDefaultButtonsForRadioControllers()
    }
    
    private func configureView() {
        title = "Settings"
    }
    
    private func setUpDefaultButtonsForRadioControllers() {
        guard let defaultButtonForSexCategory = sexRadioButtonController.buttonsArray.first(where: { $0.currentTitle == "Male" }) else {
            return
        }
        sexRadioButtonController.defaultButton = defaultButtonForSexCategory
    }
    
    private func setUpProfileSettingsTableView() {
        profileSettingsView.profileSettingsTableView.delegate = self
        profileSettingsView.profileSettingsTableView.dataSource = self
        profileSettingsView.profileSettingsTableView.register(CustomTextFieldTableViewCell.self, forCellReuseIdentifier: CustomTextFieldTableViewCell.customTextFieldTableViewCellReuseId)
        profileSettingsView.profileSettingsTableView.register(CustomRadioButtonTableViewCell.self, forCellReuseIdentifier: CustomRadioButtonTableViewCell.customReuseIdForSexCategory)
    }
    
    private func setUpProfileSettingsTextField(_ textField: UITextField) {
        textField.delegate = self
    }
}

// MARK: - ProfileSettingsPresenterInputProtocol

extension ProfileSettingsViewController: ProfileSettingsPresenterInputProtocol {
    func obtainTextFieldData() -> String {
        return ""
    }
}

// MARK: - UITableViewDelegate

extension ProfileSettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: .leastNormalMagnitude))
        let label = UILabel()
        label.frame = CGRect.init(x: 16, y: 15, width: headerView.frame.width - 32, height: headerView.frame.height - 30)
        switch section {
        case 0:
            label.text = "Your preferences"
        case 1:
            label.text = "Your name"
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

extension ProfileSettingsViewController: UITableViewDataSource {    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        case 1:
            return 1
        default:
            return 1
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0...2:
                guard let tableViewCell = tableView.dequeueReusableCell(withIdentifier: CustomRadioButtonTableViewCell.customReuseIdForSexCategory) as? CustomRadioButtonTableViewCell else {
                    return UITableViewCell()
                }
                switch indexPath.row {
                case 0:
                    tableViewCell.configureCell(with: "Male")
                case 1:
                    tableViewCell.configureCell(with: "Female")
                case 2:
                    tableViewCell.configureCell(with: "Unisex")
                default:
                    break
                }
                sexRadioButtonController.addButtonForRadioController(tableViewCell.radioButton)
                return tableViewCell
            default:
                return UITableViewCell()
            }
        case 1:
            switch indexPath.row {
            case 0:
                guard let tableViewCell = tableView.dequeueReusableCell(withIdentifier: CustomTextFieldTableViewCell.customTextFieldTableViewCellReuseId) as? CustomTextFieldTableViewCell else {
                    return UITableViewCell()
                }
                tableViewCell.configureCell(with: "Ivan")
                setUpProfileSettingsTextField(tableViewCell.textField)
                return tableViewCell
            default:
                return UITableViewCell()
            }
        default:
            return UITableViewCell()
        }
    }
}
