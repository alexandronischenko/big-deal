import UIKit
import SnapKit

class ProfileSubscriptionsView: UIView {
    
    // MARK: - Properties
    
    lazy var profileSubscriptionsTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private lazy var profileSubscriptionsApplyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Apply", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(profileSubscriptionsApplyButtonDidPressed), for: .touchUpInside)
        button.sizeToFit()
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
        profileSubscriptionsApplyButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(16)
        }
        profileSubscriptionsTableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalTo(profileSubscriptionsApplyButton).inset(40)
        }
    }
    
    private func setUpSelfView() {
        addSubview(profileSubscriptionsTableView)
        addSubview(profileSubscriptionsApplyButton)
    }
    
    // MARK: - OBJC funcs
    
    @objc private func profileSubscriptionsApplyButtonDidPressed() {
        print("profile subscriptions apply button did pressed")
    }
}
