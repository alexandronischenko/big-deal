import Foundation

protocol ValidationServiceProtocol: AnyObject {
    func isValidName(_ name: String) -> Bool
}
