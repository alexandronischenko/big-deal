import UIKit
import SnapKit

// MARK: - AuthenticationLoginViewProtocol
protocol AuthenticationLoginViewProtocol: AnyObject {
    func didPressedLogin(email: String, password: String)
    func didPressedRegister()
    func presentAlert(error: String)
}

class AuthenticationLoginView: UIView {
    // MARK: - Properties
    
    weak var delegate: AuthenticationLoginViewProtocol?

    lazy var scrollView: UIScrollView = {
        var scroll = UIScrollView()
        scroll.clipsToBounds = true
        return scroll
    }()
    
    lazy var emojiLabel: UILabel = {
        var label = UILabel()
        label.text = "🔑"
        label.font = label.font.withSize(30)
        label.baselineAdjustment = .alignCenters
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    lazy var authLabel: UILabel = {
        var label = UILabel()
        label.text = "Authorization"
        label.font = .systemFont(ofSize: 26, weight: .semibold)
        label.baselineAdjustment = .alignCenters
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    lazy var emailTextField: UITextField = {
        var textField = UITextField()
        textField.placeholder = "Enter your email"
        textField.autocorrectionType = .no
        textField.textContentType = .emailAddress
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        var textField = UITextField()
        textField.placeholder = "Enter your password"
        textField.autocorrectionType = .no
        textField.textContentType = .password
        textField.isSecureTextEntry = true
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    lazy var accountLabel: UILabel = {
        var label = UILabel()
        label.text = "I don't have an account"
        label.font = label.font.withSize(15)
        label.baselineAdjustment = .alignCenters
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    lazy var createAccountButton: UIButton = {
        var button = UIButton(type: .system)
        button.setTitle("Create an account", for: .normal)
        button.addTarget(self, action: #selector(didPressedRegisterButton), for: .touchUpInside)
        return button
    }()
    
    lazy var button: UIButton = {
        var button = UIButton(type: .system)
        button.setTitle("Sign in", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 6
        button.addTarget(self, action: #selector(didPressedLoginButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Initializers
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground

        scrollView.addSubview(emojiLabel)
        scrollView.addSubview(authLabel)
        scrollView.addSubview(emailTextField)
        scrollView.addSubview(passwordTextField)
        scrollView.addSubview(accountLabel)
        scrollView.addSubview(createAccountButton)
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
            make.top.equalTo(scrollView.snp.top).offset(128)
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
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(10)
            make.leading.equalTo(emailTextField.snp.leading)
            make.trailing.equalTo(emailTextField.snp.trailing)
        }
        accountLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.leading.equalTo(passwordTextField.snp.leading)
            make.trailing.equalTo(passwordTextField.snp.trailing)
        }
        createAccountButton.snp.makeConstraints { make in
            make.top.equalTo(accountLabel.snp.bottom)
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
    
    @objc func didPressedLoginButton() {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            return
        }
        delegate?.didPressedLogin(email: email, password: password)
    }
    
    @objc func didPressedRegisterButton() {
        delegate?.didPressedRegister()
    }
}
