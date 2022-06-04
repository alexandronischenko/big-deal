import Foundation
import UIKit

class ProfileSettingsView: UIView {
    // MARK: - Properties
    
    lazy var profileSettingsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private lazy var profileSettingsApplyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Apply", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
        button.sizeToFit()
        button.addTarget(self, action: #selector(profileSettingsApplyButtonDidPressed), for: .touchUpInside)
        return button
    }()
    // MARK: - Overrided
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUpConstraintsForViews()
    }
    // Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        setUpSelfView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Private funcs
    
    private func setUpConstraintsForViews() {
        profileSettingsApplyButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(16)
        }
        profileSettingsTableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalTo(profileSettingsApplyButton).inset(40)
        }
    }
    
    private func setUpSelfView() {
        addSubview(profileSettingsTableView)
        addSubview(profileSettingsApplyButton)
    }
    // MARK: - OBJC funcs
    
    @objc private func profileSettingsApplyButtonDidPressed(_ sender: UIButton) {
        Logger.log(level: .info, str: "profile settings apply button did pressed", shouldLogContext: true)
    }
}
