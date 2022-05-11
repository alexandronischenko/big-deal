import Foundation

// UserModel is using in DatabaseManager and needed for authorization
struct UserModel {
    let name: String
    let emailAdress: String
    let profilePicture: String?
    
    var safeEmail: String {
        var email = emailAdress.replacingOccurrences(of: ".", with: "-")
        email = email.replacingOccurrences(of: "@", with: "-")
        return email
    }
}
