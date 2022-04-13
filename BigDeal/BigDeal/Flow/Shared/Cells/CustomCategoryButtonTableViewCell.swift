import UIKit

class CustomCategoryButtonTableViewCell: UITableViewCell {
    // MARK: - Static properties
    
    static let customCategoryButtonTableViewCellReuseId: String = "customCategoryButtonTableViewCell"
    
    // MARK: - Properties
    
    lazy var categoryButton: UIButton = {
        let button = UIButton(type: .custom)
        let buttonImage = UIImage(systemName: "chevron.right")
        button.setImage(buttonImage, for: .normal)
        button.tintColor = .label
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        button.semanticContentAttribute = UIApplication.shared
            .userInterfaceLayoutDirection == .rightToLeft ? .forceLeftToRight : .forceRightToLeft
        button.contentHorizontalAlignment = .left
        button.sizeToFit()
        button.addTarget(self, action: #selector(categoryButtonDidPressed), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Overrided
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUpConstraintsForViews()
    }
    
    // Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpSelfContentView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private functions
    
    private func setUpSelfContentView() {
        contentView.isUserInteractionEnabled = false
        contentView.addSubview(categoryButton)
    }
    
    private func setUpConstraintsForViews() {
        categoryButton.snp.makeConstraints { make in
            make.bottom.top.equalToSuperview().inset(2)
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    private func setUpTitleForCategoryButton(_ title: String) {
        categoryButton.setTitle(title, for: .normal)
        categoryButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: self.frame.width - 32 - categoryButton.intrinsicContentSize.width, bottom: 0, right: 0)
    }
    
    // MARK: - Other functions
    
    func configureButton(with title: String) {
        setUpTitleForCategoryButton(title)
    }
    
    // MARK: - OBJC functions
    
    @objc func categoryButtonDidPressed() {
    }
}
