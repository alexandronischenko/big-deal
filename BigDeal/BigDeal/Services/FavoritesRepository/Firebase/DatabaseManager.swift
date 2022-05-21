import Foundation
import FirebaseDatabase

private enum DatabaseManagerError: Error {
    case gettingUserEmail
    case gettingUserData
    case invalidData
    case failedToWriteData
    case failedToReadData
}

final class DatabaseManager {
    static let shared = DatabaseManager()
    
    private let database = Database.database(url: "https://big-deal-31648-default-rtdb.firebaseio.com/").reference()
}

extension DatabaseManager: DatabaseManagerProtocol {
    func getAllFavorites(completion: @escaping (Result<[String], Error>) -> Void) {
        guard let email = UserDefaults.standard.string(forKey: UserDefaultsKeys.safeEmailKey) else {
            completion(.failure(DatabaseManagerError.invalidData))
            return
        }
        
        let ref = database.child(email).child("favorites")
        ref.observeSingleEvent(of: .value) { snapshot in
            print(snapshot)
            var idArray: [String] = []
            if let values = snapshot.value as? [String: String] {
                for id in values {
                    idArray.append(id.key)
                }
            }
            completion(.success(idArray))
        }
    }
    
    func insertUser(with user: UserModel) {
        database.child(user.safeEmail).setValue([
            "name": user.name,
            "profile_picture": "",
            "favorites": ""
        ])
    }
    
    func addToFavorites(model: Item, completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let email = UserDefaults.standard.string(forKey: UserDefaultsKeys.safeEmailKey) else {
            completion(.failure(DatabaseManagerError.gettingUserEmail))
            return
        }
        let reference = database.child(email).child("favorites")
        reference.updateChildValues([ model.id: model.clothTitle ]) { error, _ in
            guard error != nil else {
                completion(.failure(DatabaseManagerError.failedToWriteData))
                return
            }
            completion(.success(true))
        }
    }
    
    func deleteFromFavorites(model: Item, completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let email = UserDefaults.standard.string(forKey: UserDefaultsKeys.safeEmailKey) else { return }
        let id = model.id
        database.child(email).child("favorites").child(id).removeValue { error, _ in
            guard error != nil else {
                completion(.failure(DatabaseManagerError.failedToWriteData))
                return
            }
            completion(.success(true))
        }
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
    
    func isFavorite(model: Item, completion: @escaping (Result<Bool, Error>) -> Void) {
        var favorites: [String] = []
        getAllFavorites { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let arrayOfFavorites):
                favorites = arrayOfFavorites
                let isFav = favorites.contains(model.id)
                completion(.success(isFav))
        }
            completion(.failure(DatabaseManagerError.failedToReadData))
        }
    }
    
    func getCurrentUserModel(completion: @escaping (Result<UserModel, Error>) -> Void) {
        guard let email = UserDefaults.standard.string(forKey: UserDefaultsKeys.safeEmailKey) else { completion(.failure(DatabaseManagerError.gettingUserEmail))
            return
        }
        database.child(email).observeSingleEvent(of: .value) { snapshot in
            guard let value = snapshot.value as? [String: String] else {
                completion(.failure(DatabaseManagerError.invalidData))
                return
            }
            guard let userName = value["name"] else {
                completion(.failure(DatabaseManagerError.invalidData))
                return
            }
            let model = UserModel(name: userName, emailAdress: email, profilePicture: nil)
            completion(.success(model))
        }
    }
}