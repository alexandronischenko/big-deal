import Foundation
import FirebaseDatabase

final class DatabaseManager {
    static let shared = DatabaseManager()
    
    private let database = Database.database(url: "https://big-deal-31648-default-rtdb.firebaseio.com/").reference()
}

extension DatabaseManager: DatabaseManagerProtocol {
    func insertUser(with user: UserModel) {
        database.child(user.safeEmail).setValue([
            "name": user.name,
            "profile_picture": "",
            "favorites": ""
        ])
    }
    
    func addToFavorites(url: String) {
        guard let email = UserDefaults.standard.string(forKey: UserDefaultsKeys.safeEmailKey) else { return }
        database.child(email).child("favorites").setValue([
            url: url
        ])
    }
    
    func deleteUser(with email: String, completion: @escaping ((Bool) -> Void)) {
        database.child(email).removeValue()
    }

    func deleteFavoritesWith(url: String, from email: String) {
        database.child(email).child("favorites").child(url).removeValue()
    }
    
    func userExists(withEmail email: String, completion: @escaping ((Bool) -> Void)) {
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        
        database.child(safeEmail).observeSingleEvent(of: .value) { snapshot in
            guard snapshot.value as? String != nil else {
                completion(false)
                return
            }
            completion(true)
        }
    }
}
