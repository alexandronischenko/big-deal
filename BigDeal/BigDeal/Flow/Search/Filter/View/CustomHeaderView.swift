import UIKit

protocol CustomHeaderViewDelegate: AnyObject {
    func expandedSection(button: UIButton)
}

class CustomHeaderView: UITableViewHeaderFooterView {
    // MARK: - Static properties
    
    static let customHeaderViewReuseId: String = "customHeaderFooterView"
    
    // MARK: - Properies
    
    weak var delegate: CustomHeaderViewDelegate?
    
    lazy var customHeaderViewButton: UIButton = {
        let button = UIButton(type: .custom)
        let buttonImage = UIImage(systemName: "chevron.right")
        button.setImage(buttonImage, for: .normal)
        button.tintColor = .label
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        button.semanticContentAttribute = UIApplication.shared
            .userInterfaceLayoutDirection == .rightToLeft ? .forceLeftToRight : .forceRightToLeft
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(customHeaderViewButtonDidPressed), for: .touchUpInside)
        return button
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubview(customHeaderViewButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUpConstrainst()
    }
    
    func setUpConstrainst() {
        customHeaderViewButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(30)
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    func configure(title: String, section: Int) {
        customHeaderViewButton.setTitle(title, for: .normal)
        customHeaderViewButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: self.frame.width - 32 - customHeaderViewButton.intrinsicContentSize.width, bottom: 0, right: 0)
        customHeaderViewButton.tag = section
    }
    
    @objc private func customHeaderViewButtonDidPressed(_ sender: UIButton) {
        delegate?.expandedSection(button: sender)
    }
}
