import UIKit

class CustomCheckBoxTableViewCell: UITableViewCell {
    // MARK: - Static properties
    
    static let customReuseIdForCategoriesCheckBox: String = "customReuseIdForCategoriesCheckBox"
    static let customReuseIdForBrandsCheckBox: String = "customReuseIdForBrandsCheckBox"
    static let customReuseIdForSizesCheckBox: String = "customReuseIdForSizesCheckBox"
    static let customReuseIdForShopsCheckBox: String = "customReuseIdForShopsCheckBox"
    
    // MARK: - UI
    
    lazy var checkBoxButton: UIButton = {
        let button = UIButton(type: .custom)
        button.tintColor = .systemBlue
        button.setTitleColor(.label, for: .selected)
        button.setTitleColor(.label, for: .normal)
        button.contentHorizontalAlignment = .left
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        button.sizeToFit()
        return button
    }()
    // MARK: - Overrided
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUpSelfContentView()
        setUpConstraintsForViews()
    }
    
    override func prepareForReuse() {
        checkBoxButton.isSelected = false
    }
    // Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Private functions
    
    private func setTitleForCheckBox(_ title: String) {
        checkBoxButton.setTitle(title, for: .normal)
        checkBoxButton.setTitle(title, for: .selected)
    }
    
    private func setUpSelfContentView() {
        contentView.backgroundColor = .systemBackground
        contentView.isUserInteractionEnabled = true
        contentView.addSubview(checkBoxButton)
    }
    
    private func setUpConstraintsForViews() {
        checkBoxButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(3)
        }
    }
    // MARK: - Other functions
    
    func configureCell(with title: String) {
        setTitleForCheckBox(title)
    }
}
