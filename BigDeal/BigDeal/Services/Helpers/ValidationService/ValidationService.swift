import Foundation

class ValidationService: ValidationServiceProtocol {
    // MARK: - Functions
    
    func isValidName(_ name: String) -> Bool {
        let usernamePredicate = #"^[a-zA-Z0-9]([._-](?![._-])|[a-zA-Z0-9]){3,18}[a-zA-Z0-9]$"#
        let result = name.range(
            of: usernamePredicate,
            options: .regularExpression
        )
        return (result != nil)
    }
}
