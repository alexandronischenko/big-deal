import UIKit

class AuthenticationRegisterViewController: UIViewController {
    // MARK: - Properties
    
    var presenter: AuthenticationRegisterViewPresenterProtocol
    var registerView = AuthenticationRegisterView()
    // MARK: - Initializers
    
    init(presenter: AuthenticationRegisterViewPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = registerView
    }
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.tabBarItem.title = "Register"
    }
}
// MARK: - AuthenticationRegisterViewProtocol

extension AuthenticationRegisterViewController: AuthenticationRegisterViewProtocol {
    func emailTextFieldDidChange(textField: UITextField) {
        presenter.emailDidChange(textField: textField)
    }
    
    func nameTextFieldDidChange(textField: UITextField) {
        presenter.nameDidChange(textField: textField)
    }
    
    func passwordTextFieldDidChange(textField: UITextField) {
        presenter.passwordDidChange(textField: textField)
    }
    
    func didPressedRegister(email: String, name: String, password: String) {
        presenter.didPressedRegister(email: email, name: name, password: password)
    }
    
    func didPressedLogin() {
        presenter.didPressedLogin()
    }
    
    func showErrorLabel(_ error: String) {
        registerView.showErrorLabel(text: error)
    }
    
    func changeTextFieldColor(_ sender: UITextField) {
        registerView.changeTextFieldColor(sender)
    }
    
    func resetTextFieldColor(_ sender: UITextField) {
        registerView.resetTextFieldColor(sender)
    }
}
