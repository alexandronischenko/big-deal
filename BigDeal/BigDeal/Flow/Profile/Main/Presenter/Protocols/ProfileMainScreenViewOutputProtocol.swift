import Foundation

protocol ProfileMainPresenterOutputProtocol: AnyObject {
    func moveToSettingsScreen()
    func moveToSubscriptionsScreen()
    func moveToDetailFlow(model: Item)
    func didTapLogout()
    
    func getData()
}
