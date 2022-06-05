import Foundation

enum Errors: Error {
    case collectingError(ErrorsDescriptions)
    case isNotLoggedIn
}

enum ErrorsDescriptions: String {
    case collectingError = "Collecting data error❗️. Review your data and try again❗️"
    case arrayObtainingError = "Cannot convert data to desired type❗️"
}

extension Errors: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .isNotLoggedIn:
            return NSLocalizedString("You need to login to add to favorites❗️", comment: "Error")
        case .collectingError(let error):
            switch error {
            case .collectingError:
                return NSLocalizedString("Collecting data error❗️. Review your data and try again❗️", comment: "Error")
            case .arrayObtainingError:
                return NSLocalizedString("Cannot convert data to desired type❗️", comment: "Error")
            }
        }
    }
}
