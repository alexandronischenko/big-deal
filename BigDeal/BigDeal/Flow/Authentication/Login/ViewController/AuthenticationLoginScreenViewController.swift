import UIKit

class AuthenticationLoginScreenViewController: UIViewController {
    
    // MARK: - Properties
    
    var presenter: AuthenticationLoginViewPresenterProtocol
    var loginView = AuthenticationLoginView()
    
    // MARK: - Initializers
    
    init(presenter: AuthenticationLoginViewPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = loginView
    }
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.tabBarItem.title = "Login"
    }
}

// MARK: - AuthenticationLoginViewProtocol
extension AuthenticationLoginScreenViewController: AuthenticationLoginViewProtocol {
    func presentAlert(error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func didPressedLogin(email: String, password: String) {
        presenter.didPressedLogin(email: email, password: password)
    }
    
    func didPressedRegister() {
        presenter.didPressedRegister()
    }
}
