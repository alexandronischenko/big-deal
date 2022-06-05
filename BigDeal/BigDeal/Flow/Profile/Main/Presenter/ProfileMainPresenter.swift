import Foundation
import UIKit
import FirebaseAuth

class ProfileMainPresenter {
    // MARK: - Properties
    
    weak var input: ProfileMainPresenterInputProtocol?
    var coordinator: ProfileBaseCoordinatorProtocol?
    var repository: FavoritesRepositoryProtocol?
    // MARK: - Initializers

    init(coordinator: ProfileBaseCoordinatorProtocol) {
        self.coordinator = coordinator
    }
}
// MARK: - ProfileBaseCoordinatedProtocol

extension ProfileMainPresenter: ProfileBaseCoordinatedProtocol {
}
// MARK: - ProfileMainPresenterOutputProtocol

extension ProfileMainPresenter: ProfileMainPresenterOutputProtocol {
    func getData() {
        repository?.obtainAll { result in
            switch result {
            case .success(let items):
                self.input?.getData(data: items)
            case .failure:
                break
            }
        }
    }
    
    func didTapLogout() {
        let alert = UIAlertController(title: "Are you sure you want to log out of your account?", message: "We will miss you(", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive) { _ in
            do {
                try FirebaseAuth.Auth.auth().signOut()
                UserDefaults.standard.set(false, forKey: UserDefaultsKeys.isLoggedInKey)
                UserDefaults.standard.set(nil, forKey: UserDefaultsKeys.safeEmailKey)
                CoreDataManager.shared.delete { result in
                    switch result {
                    case .success:
                        break
                    case .failure(let error):
                        Logger.log(level: .error, str: "Failed to logout. \(error.localizedDescription)", shouldLogContext: true)
                    }
                }
            } catch {
                Logger.log(level: .error, str: "Failed to logout. \(error.localizedDescription)", shouldLogContext: true)
            }
            self.coordinator?.moveTo(flow: .authProfile(.authentication(.greeting)))
        })
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        input?.present(alert: alert)
    }
    
    func moveToDetailFlow(model: Item) {
        coordinator?.moveTo(flow: .authProfile(.profile(.detail(model))))
    }
    
    func moveToSettingsScreen() {
        coordinator?.moveTo(flow: .authProfile(.profile(.settings)))
    }
    
    func moveToSubscriptionsScreen() {
        coordinator?.moveTo(flow: .authProfile(.profile(.subscriptions)))
    }
}
