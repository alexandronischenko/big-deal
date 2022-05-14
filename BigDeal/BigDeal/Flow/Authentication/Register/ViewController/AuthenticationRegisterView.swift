import Foundation
import UIKit
import SnapKit

// MARK: - AuthenticationRegisterViewProtocol

protocol AuthenticationRegisterViewProtocol: AnyObject {
    func didPressedLogin()
    func didPressedRegister(email: String, name: String, password: String)
    
    func showErrorLabel(_ error: String)
    func changeTextFieldColor(_ sender: UITextField)
    func resetTextFieldColor(_ sender: UITextField)
    
    func emailTextFieldDidChange(textField: UITextField)
    func nameTextFieldDidChange(textField: UITextField)
    func passwordTextFieldDidChange(textField: UITextField)
}

class AuthenticationRegisterView: UIView {
    // MARK: - Properties
    
    weak var delegate: AuthenticationRegisterViewProtocol?
    
    lazy var scrollView: UIScrollView = {
        var scroll = UIScrollView()
        scroll.clipsToBounds = true
        return scroll
    }()
    
    lazy var emojiLabel: UILabel = {
        var label = UILabel()
        label.text = "✍️"
        label.font = label.font.withSize(30)
        label.baselineAdjustment = .alignCenters
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    lazy var authLabel: UILabel = {
        var label = UILabel()
        label.text = "Registration"
        label.font = .systemFont(ofSize: 26, weight: .semibold)
        label.baselineAdjustment = .alignCenters
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    lazy var emailTextField: UITextField = {
        var textField = UITextField()
        textField.placeholder = "Enter your email"
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        textField.textContentType = .emailAddress
        textField.keyboardType = .emailAddress
        textField.addTarget(self, action: #selector(AuthenticationRegisterView.emailTextFieldDidChange(_:)), for: .editingChanged)
        return textField
    }()
    
    lazy var nameTextField: UITextField = {
        var textField = UITextField()
        textField.placeholder = "Enter your name"
        textField.borderStyle = .roundedRect
//        textField.autocorrectionType = .no
        textField.textContentType = .name
        textField.addTarget(self, action: #selector(nameTextFieldDidChange), for: .editingChanged)
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        var textField = UITextField()
        textField.placeholder = "Enter your password"
        textField.borderStyle = .roundedRect
//        textField.autocorrectionType = .default
        textField.textContentType = .password
        textField.isSecureTextEntry = true
        textField.addTarget(self, action: #selector(passwordTextFieldDidChange), for: .editingChanged)
        return textField
    }()
    
    lazy var repeatPasswordTextField: UITextField = {
        var textField = UITextField()
        textField.placeholder = "Enter your password again"
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        textField.textContentType = .password
        textField.isSecureTextEntry = true
        textField.addTarget(self, action: #selector(repeatPasswordTextFieldDidChange), for: .editingChanged)
        return textField
    }()
    
    lazy var accountLabel: UILabel = {
        var label = UILabel()
        label.text = "I'm already registered"
        label.font = label.font.withSize(15)
        label.baselineAdjustment = .alignCenters
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    lazy var errorLabel: UILabel = {
        var label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.baselineAdjustment = .alignCenters
        label.textAlignment = .center
        label.textColor = .systemRed
        label.sizeToFit()
        return label
    }()
    
    lazy var loginButton: UIButton = {
        var button = UIButton(type: .system)
        button.setTitle("Sign in by email", for: .normal)
        button.addTarget(self, action: #selector(didPressedLoginButton), for: .touchUpInside)
        return button
    }()
    
    lazy var button: UIButton = {
        var button = UIButton(type: .system)
        button.setTitle("Register", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 6
        button.addTarget(self, action: #selector(didPressedRegisterButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - View lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        
        scrollView.addSubview(emojiLabel)
        scrollView.addSubview(authLabel)
        scrollView.addSubview(emailTextField)
        scrollView.addSubview(nameTextField)
        scrollView.addSubview(passwordTextField)
        scrollView.addSubview(repeatPasswordTextField)
        scrollView.addSubview(accountLabel)
        scrollView.addSubview(errorLabel)
        scrollView.addSubview(loginButton)
        scrollView.addSubview(button)
        addSubview(scrollView)
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private functions
    
    private func setConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        emojiLabel.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.top).offset(96)
            make.centerX.equalTo(scrollView.snp.centerX)
        }
        authLabel.snp.makeConstraints { make in
            make.top.equalTo(emojiLabel.snp.bottom)
            make.centerX.equalTo(emojiLabel.snp.centerX)
        }
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(authLabel.snp.bottom).offset(20)
            make.centerX.equalTo(authLabel.snp.centerX)
            make.width.equalTo(scrollView.snp.width).multipliedBy(0.9)
        }
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(10)
            make.leading.equalTo(emailTextField.snp.leading)
            make.trailing.equalTo(emailTextField.snp.trailing)
        }
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(10)
            make.leading.equalTo(emailTextField.snp.leading)
            make.trailing.equalTo(emailTextField.snp.trailing)
        }
        repeatPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(10)
            make.leading.equalTo(passwordTextField.snp.leading)
            make.trailing.equalTo(passwordTextField.snp.trailing)
        }
        accountLabel.snp.makeConstraints { make in
            make.top.equalTo(repeatPasswordTextField.snp.bottom).offset(20)
            make.leading.equalTo(repeatPasswordTextField.snp.leading)
            make.trailing.equalTo(repeatPasswordTextField.snp.trailing)
        }
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(accountLabel.snp.bottom)
            make.leading.equalTo(passwordTextField.snp.leading)
            make.trailing.equalTo(passwordTextField.snp.trailing)
        }
        errorLabel.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom)
            make.leading.equalTo(passwordTextField.snp.leading)
            make.trailing.equalTo(passwordTextField.snp.trailing)
        }
        button.snp.makeConstraints { make in
            make.bottom.equalTo(scrollView.safeAreaLayoutGuide.snp.bottom).inset(16)
            make.leading.equalTo(passwordTextField.snp.leading)
            make.trailing.equalTo(passwordTextField.snp.trailing)
        }
    }
    
    // MARK: - Obj-c functions
    
    @objc func emailTextFieldDidChange(_ textField: UITextField) {
        delegate?.emailTextFieldDidChange(textField: textField)
    }
    
    @objc func nameTextFieldDidChange(_ textField: UITextField) {
        delegate?.nameTextFieldDidChange(textField: textField)
    }
    
    @objc func passwordTextFieldDidChange(_ textField: UITextField) {
        delegate?.passwordTextFieldDidChange(textField: textField)
    }
    
    @objc func repeatPasswordTextFieldDidChange(_ textField: UITextField) {
//        guard let text = textField.text else { return }
//        delegate?.passwordTextFieldDidChange(textField: textField)
//        if passwordTextField.text != text {
//            changeTextFieldColor(textField)
//            showErrorLabel(text: "Passwords do not match")
//        } else {
            delegate?.passwordTextFieldDidChange(textField: textField)
//            showErrorLabel(text: "")
//            resetTextFieldColor(textField)
//        }
    }
    
    @objc func didPressedLoginButton() {
        delegate?.didPressedLogin()
    }
    
    @objc func didPressedRegisterButton() {
        guard let email = emailTextField.text, let name = nameTextField.text, let password = passwordTextField.text else {
            return
        }
        delegate?.didPressedRegister(email: email, name: name, password: password)
    }
    
    // MARK: - Functions
    
    func showErrorLabel(text: String) {
        errorLabel.text = text
    }
    
    func changeTextFieldColor(_ sender: UITextField) {
        sender.layer.borderWidth = 0.5
        sender.layer.cornerRadius = 6
        sender.layer.borderColor = UIColor.systemRed.cgColor
    }
    
    func resetTextFieldColor(_ sender: UITextField) {
        sender.borderStyle = .roundedRect
        sender.layer.borderColor = UIColor.systemGreen.cgColor
    }
}
