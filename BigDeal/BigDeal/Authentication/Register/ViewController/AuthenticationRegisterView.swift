//
//  AuthenticationRegisterView.swift
//  BigDeal
//
//  Created by Alexandr Onischenko on 06.04.2022.
//

import Foundation
import UIKit
import SnapKit

protocol AuthenticationRegisterViewProtocol: AnyObject {
    func didPressedLogin()
    func didPressedRegister()
    
    func showErrorLabel(_ error: String)
    func changeTextFieldColor(_ sender: UITextField)
    func resetTextFieldColor(_ sender: UITextField)
    
    func emailTextFieldDidChange(textField: UITextField)
    func nameTextFieldDidChange(textField: UITextField)
    func passwordTextFieldDidChange(textField: UITextField)
}

class AuthenticationRegisterView: UIView {
    weak var delegate: AuthenticationRegisterViewProtocol?
    
    var scrollView: UIScrollView = {
        var scroll = UIScrollView()
        scroll.clipsToBounds = true
        return scroll
    }()
    
    var emojiLabel: UILabel = {
        var label = UILabel()
        label.text = "✍️"
        label.font = label.font.withSize(30)
        label.baselineAdjustment = .alignCenters
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    var authLabel: UILabel = {
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
        textField.addTarget(self, action: #selector(AuthenticationRegisterView.emailTextFieldDidChange(_:)), for: .editingChanged)
        return textField
    }()
    
    lazy var nameTextField: UITextField = {
        var textField = UITextField()
        textField.placeholder = "Enter your name"
        textField.borderStyle = .roundedRect
        textField.addTarget(self, action: #selector(nameTextFieldDidChange), for: .editingChanged)
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        var textField = UITextField()
        textField.placeholder = "Enter your password"
        textField.borderStyle = .roundedRect
        textField.addTarget(self, action: #selector(passwordTextFieldDidChange), for: .editingChanged)
        return textField
    }()
    
    lazy var repeatPasswordTextField: UITextField = {
        var textField = UITextField()
        textField.placeholder = "Enter your password again"
        textField.borderStyle = .roundedRect
        textField.addTarget(self, action: #selector(repeatPasswordTextFieldDidChange), for: .editingChanged)
        return textField
    }()
    
    var accountLabel: UILabel = {
        var label = UILabel()
        label.text = "I'm already registered"
        label.font = label.font.withSize(15)
        label.baselineAdjustment = .alignCenters
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    var errorLabel: UILabel = {
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
    
    func setConstraints() {
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
        guard let text = textField.text else { return }
        if passwordTextField.text != text {
            showErrorLabel(text: "Passwords do not match")
        } else {
            showErrorLabel(text: "")
        }
    }
    
    @objc func didPressedLoginButton() {
        delegate?.didPressedLogin()
    }
    
    @objc func didPressedRegisterButton() {
        delegate?.didPressedRegister()
    }
    
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
