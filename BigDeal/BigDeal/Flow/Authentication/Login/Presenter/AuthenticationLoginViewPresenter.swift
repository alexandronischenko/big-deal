import Foundation
import FirebaseAuth

// MARK: - AuthenticationLoginViewPresenterProtocol

protocol AuthenticationLoginViewPresenterProtocol: AnyObject {
    func didPressedLogin(email: String, password: String)
    func didPressedRegister()
}

class AuthenticationLoginViewPresenter: AuthenticationBaseCoordinatedProtocol {
    // MARK: - Properties
    
    weak var view: AuthenticationLoginViewProtocol?
    var coordinator: AuthenticationBaseCoordinatorProtocol?
    
    // MARK: - Initializers
    
    init(coordinator: AuthenticationCoordinator) {
        self.coordinator = coordinator
    }
}

// MARK: - AuthenticationLoginViewPresenterProtocol

extension AuthenticationLoginViewPresenter: AuthenticationLoginViewPresenterProtocol {
    func didPressedLogin(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { _, error in
            if let error = error {
                print("Error sign in \(error)")
                self.view?.presentAlert(error: error.localizedDescription)
                return
            } else {
                UserDefaults.standard.set(true, forKey: UserDefaultsKeys.isLoggedInKey)
                self.coordinator?.moveTo(flow: .authProfile(.profile(.main)))
            }
        }
    }
    
    func didPressedRegister() {
        coordinator?.moveTo(flow: .authProfile(.authentication(.register)))
    }
}
