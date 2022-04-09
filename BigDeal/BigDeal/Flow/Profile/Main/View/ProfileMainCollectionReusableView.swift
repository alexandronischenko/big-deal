import UIKit

protocol HeaderCollectionReusableViewDelegate: AnyObject {
    func moveToSettingsScreen()
    func moveToSubscriptionsScreen()
}

class ProfileMainCollectionReusableView: UICollectionReusableView {
    // MARK: - Static properties
    
    static let customHeaderCollectionReusableViewId = "customHeaderCollectionReusableView"
    
    // MARK: - Properies
    
    weak var delegate: HeaderCollectionReusableViewDelegate?
    
    private lazy var profileHeaderImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .systemBlue
        imageView.image = UIImage(systemName: "person.circle.fill")
        return imageView
    }()
    
    private lazy var profileHeaderFullNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24)
        label.text = "Murtazin Renat"
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()
    
    private lazy var profileHeaderSettingsButton: UIButton = {
        let button = UIButton(type: .custom)
        let buttonImage = UIImage(systemName: "chevron.right")
        button.setImage(buttonImage, for: .normal)
        button.setTitle("Profile settings", for: .normal)
        button.tintColor = .label
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        button.semanticContentAttribute = UIApplication.shared
            .userInterfaceLayoutDirection == .rightToLeft ? .forceLeftToRight : .forceRightToLeft
        button.contentHorizontalAlignment = .left
        button.sizeToFit()
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: self.frame.width - 32 - button.frame.width, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(profileSettingsButtonDidPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var profileHeaderSubscriptionsSettingsButton: UIButton = {
        let button = UIButton(type: .custom)
        let buttonImage = UIImage(systemName: "chevron.right")
        button.setImage(buttonImage, for: .normal)
        button.setTitle("Subscribes settings", for: .normal)
        button.tintColor = .label
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        button.semanticContentAttribute = UIApplication.shared
            .userInterfaceLayoutDirection == .rightToLeft ? .forceLeftToRight : .forceRightToLeft
        button.contentHorizontalAlignment = .left
        button.sizeToFit()
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: self.frame.width - 32 - button.frame.width, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(subscriptionsSettingsButtonDidPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var profileHeaderMyClothesLabel: UILabel = {
        let label = UILabel()
        label.text = "My clothes"
        label.textColor = .label
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    // MARK: - Overrided
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUpConstraintsForViews()
    }
    
    // Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpSelfContentView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private funcs
    
    private func setUpSelfContentView() {
        addSubview(profileHeaderImageView)
        addSubview(profileHeaderFullNameLabel)
        addSubview(profileHeaderSettingsButton)
        addSubview(profileHeaderSubscriptionsSettingsButton)
        addSubview(profileHeaderMyClothesLabel)
    }
    
    private func setUpConstraintsForViews() {
        profileHeaderImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
            make.height.width.equalTo(60)
        }
        profileHeaderFullNameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(profileHeaderImageView)
            make.trailing.equalToSuperview().inset(16)
        }
        profileHeaderSettingsButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(profileHeaderImageView).inset(70)
        }
        profileHeaderSubscriptionsSettingsButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(profileHeaderSettingsButton).inset(40)
        }
        profileHeaderMyClothesLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalTo(profileHeaderSubscriptionsSettingsButton).inset(40)
        }
    }
    
    // MARK: - OBJC funcs
    
    @objc func profileSettingsButtonDidPressed() {
        delegate?.moveToSettingsScreen()
    }
    
    @objc private func subscriptionsSettingsButtonDidPressed() {
        delegate?.moveToSubscriptionsScreen()
    }
}
