import Foundation

enum Errors: Error {
    case collectingError(ErrorsDescriptions)
}

enum ErrorsDescriptions: String {
    case collectingError = "Collecting data error❗️. Review your data and try again❗️"
}
