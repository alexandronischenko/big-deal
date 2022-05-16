import Foundation

enum Errors: Error {
    case collectingError(ErrorsDescriptions)
}

enum ErrorsDescriptions: String {
    case collectingError = "Collecting data error❗️. Review your data and try again❗️"
    case arrayObtainingError = "Cannot convert data to desired type❗️"
}
