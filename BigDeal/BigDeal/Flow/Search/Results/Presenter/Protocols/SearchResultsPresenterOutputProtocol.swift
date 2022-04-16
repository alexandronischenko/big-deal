import Foundation

protocol SearchResultsPresenterOutputProtocol: AnyObject {
    func moveToFilterScreen()
    func moveToDetailFlow(model: Item)
}
