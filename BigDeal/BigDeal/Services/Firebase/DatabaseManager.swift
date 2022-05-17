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
    
    func addToFavorites(id: String) {
        guard let email = UserDefaults.standard.string(forKey: UserDefaultsKeys.safeEmailKey) else { return }
        database.child(email).child("favorites").updateChildValues([
            id: id
        ])
    }
    
    func deleteUser(with email: String, completion: @escaping ((Bool) -> Void)) {
        database.child(email).removeValue()
    }
    
    func deleteFavoritesWith(id: String) {
        guard let email = UserDefaults.standard.string(forKey: UserDefaultsKeys.safeEmailKey) else { return }
        database.child(email).child("favorites").child(id).removeValue()
    }
    
    func getAllFavorites() -> [String] {
        guard let email = UserDefaults.standard.string(forKey: UserDefaultsKeys.safeEmailKey) else { return [] }
        var idArray: [String] = []
//        database.child(email).child("favorites").getData(completion: { error, snapshot in
////            guard error != nil else {
////                print(error?.localizedDescription)
////                return
////            }
//            if let values = snapshot.value as? [String: String] {
//                for id in values {
//                    idArray.append(id.key)
//                }
//            }
//        })
        let ref = database.child(email).child("favorites")
        ref.observeSingleEvent(of: .value, with: { snapshot in
            print(snapshot)
            if let values = snapshot.value as? [String: String] {
                for id in values {
                    idArray.append(id.key)
                }
            }
        })
        return idArray
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
    
    func isFavorite(id: String) -> Bool {
        let ids = getAllFavorites()
        return ids.contains(id)
    }
}
