import UIKit

class ProfileMainScreenViewController: UIViewController, ProfileMainScreenViewInputProtocol, ProfileBaseCoordinated {
    
    var coordinator: ProfileBaseCoordinator?
    
    var profileMainScreenPresenter: ProfileMainScreenViewOutputProtocol!
    var profileMainScreenView = ProfileMainScreenView()
    
    override func loadView() {
        view = profileMainScreenView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
