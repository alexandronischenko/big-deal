import Foundation
import UIKit
import FirebaseAuth

class ProfileMainPresenter {
    // MARK: - Properties
    
    weak var input: ProfileMainPresenterInputProtocol?
    var coordinator: ProfileBaseCoordinatorProtocol?
    
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
    func didTapLogout() {
        do {
            try FirebaseAuth.Auth.auth().signOut()
        } catch {
            print("Failed to logout")
        }
        coordinator?.moveTo(flow: .authProfile(.authentication(.greeting)))
    }
    
    func moveToDetailFlow(model: Item) {
        let image = UIImage(systemName: "circle")
        guard let image = image else {
            return
        }
        coordinator?.moveTo(flow: .detail(.main(Item(shopTitle: "", clothTitle: "", sizes: [], oldPrice: "", newPrice: "", clothImage: image))))
    }

    func moveToSettingsScreen() {
        coordinator?.moveTo(flow: .authProfile(.profile(.settings)))
    }
    
    func moveToSubscriptionsScreen() {
        coordinator?.moveTo(flow: .authProfile(.profile(.subscriptions)))
    }
}
