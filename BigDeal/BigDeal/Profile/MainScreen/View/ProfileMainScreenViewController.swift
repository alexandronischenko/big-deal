import UIKit

class ProfileMainScreenViewController: UIViewController, ProfileMainScreenViewInputProtocol {
    
    var profileMainScreenPresenter: ProfileMainScreenViewOutputProtocol!
    var profileMainScreenView = ProfileMainScreenView()
    
    override func loadView() {
        view = profileMainScreenView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
