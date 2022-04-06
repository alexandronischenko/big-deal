import Foundation
import UIKit

class CustomTextFieldTableViewCell: UITableViewCell {
    
    // MARK: - Static properties
    
    static let customTextFieldTableViewCellReuseId: String = "customTextFieldTableViewCell"
    
    // MARK: - Properties
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.textColor = .label
        textField.textAlignment = .left
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.layer.borderColor = UIColor.systemGray.cgColor
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        textField.leftViewMode = .always
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 1.5
        textField.addTarget(self, action: #selector(textFieldDidPressed), for: .touchUpInside)
        return textField
    }()
    
    // MARK: - Overrided
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUpConstraintsForViews()
    }
    
    // Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.isUserInteractionEnabled = true
        contentView.addSubview(textField)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private funcs
    
    private func setUpConstraintsForViews() {
        textField.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(4)
            make.height.equalTo(35)
            make.width.equalTo(180)
        }
    }
    
    private func setUpPlaceholderForTextField(by text: String) {
        textField.placeholder = text
    }
    
    // MARK: - Other funcs
    
    func configureCell(with text: String) {
        setUpPlaceholderForTextField(by: text)
    }
    
    // MARK: - OBJC funcs
    
    @objc private func textFieldDidPressed() {
        print("text field has been pressed")
    }
}
