import UIKit

class AuthenticationGreetingViewController: UIViewController {
    // MARK: - Properties
    
    var presenter: AuthenticationGreetingViewPresenterProtocol
    var greetingView = AuthenticationGreetingView()
    // MARK: - Initializers
    
    init(presenter: AuthenticationGreetingViewPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = greetingView
    }
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        greetingView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.tabBarItem.title = "Greeting"
    }
}
// MARK: - AuthenticationGreetingViewProtocol

extension AuthenticationGreetingViewController: AuthenticationGreetingViewProtocol {
    func didPressedLetsGetStarted() {
        presenter.buttonPressedLetsGetStarted()
    }
}
