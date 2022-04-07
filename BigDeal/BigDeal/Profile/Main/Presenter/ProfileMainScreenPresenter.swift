import Foundation

class ProfileMainScreenPresenter: ProfileMainScreenViewOutputProtocol, ProfileMainScreenInteractorOutputProtocol {
    weak var profileMainScreenViewController: ProfileMainScreenViewInputProtocol!
    var profileMainScreenInteractor: ProfileMainScreenInteractorInputProtocol!
}
