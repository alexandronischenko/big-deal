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
    
//    private let database = Database.database(url: "https://big-deal-31648-default-rtdb.firebaseio.com/").reference()
    private let database = Database.database().reference()
}

extension DatabaseManager: DatabaseManagerProtocol {
    func getAllFavorites(completion: @escaping (Result<[Item], Error>) -> Void) {
        guard let email = UserDefaults.standard.string(forKey: UserDefaultsKeys.safeEmailKey) else {
            completion(.failure(DatabaseManagerError.invalidData))
            return
        }
        
        let ref = database.child(email).child("favorites")
        ref.observeSingleEvent(of: .value) { snapshot in
            var idArray: [String] = []
            if let values = snapshot.value as? [String: String] {
                for id in values {
                    idArray.append(id.key)
                }
            }
            
            var items: [Item] = []
            for i in 0..<idArray.count {
                items.append(Item(shopTitle: "", clothTitle: "", id: idArray[i], oldPrice: "", newPrice: "", clothImage: UIImage(), url: "", imageURL: ""))
            }
            // Необходимо сделать запрос по каждому элементу и добавить в массив
            completion(.success(items))
        }
    }
    
    func insertUser(with user: UserModel) {
        database.child(user.safeEmail).setValue([
            "name": user.name,
            "profile_picture": "",
            "favorites": ""
        ])
    }
    
    func addToFavorites(model: Item, completion: @escaping (Result<Item, Error>) -> Void) {
        guard let email = UserDefaults.standard.string(forKey: UserDefaultsKeys.safeEmailKey) else {
            completion(.failure(DatabaseManagerError.gettingUserEmail))
            return
        }
        let reference = database.child(email).child("favorites")
        reference.updateChildValues([ model.id: model.clothTitle ]) { error, _ in
            guard let error = error else {
                completion(.success(model))
                return
            }
            completion(.failure(error))
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
        var favorites: [Item] = []
      
        getAllFavorites { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let arrayOfFavorites):
                favorites = arrayOfFavorites
                let isFav = favorites.contains { element in
                    return model.id == element.id ? true : false
                }
                completion(.success(isFav))
        }
            completion(.failure(DatabaseManagerError.failedToReadData))
        }
    }
    
    func getCurrentUserModel(completion: @escaping (Result<UserModel, Error>) -> Void) {
        guard let email = UserDefaults.standard.string(forKey: UserDefaultsKeys.safeEmailKey) else { completion(.failure(DatabaseManagerError.gettingUserEmail))
            return
        }
        database.child(email).child("name").observeSingleEvent(of: .value) { snapshot in
            Logger.log(level: .info, str: "\(snapshot)", shouldLogContext: true)
            guard let value = snapshot.value as? String else {
                completion(.failure(DatabaseManagerError.invalidData))
                Logger.log(level: .error, str: "cannot get dictionary from snapshot.value \(snapshot)", shouldLogContext: true)
                return
            }
            let model = UserModel(name: value, emailAdress: email, profilePicture: nil)
            completion(.success(model))
        }
    }
    
    func getTokens(completion: @escaping (Result<[String: String], Error>) -> Void) {
        database.child("tokens").observeSingleEvent(of: .value) { snapshot in
            Logger.log(level: .info, str: "\(snapshot)", shouldLogContext: true)
            guard let value = snapshot.value as? [String: String] else {
                Logger.log(level: .error, str: "cannot get dictionary from snapshot.value \(snapshot)", shouldLogContext: true)
                completion(.failure(DatabaseManagerError.invalidData))
                return
            }
            Logger.log(level: .error, str: "\(snapshot.value)", shouldLogContext: true)
            completion(.success(value))
        }
    }
    
    func getTokens() async -> (Result<[String: String], Error>) {
        let result = await database.child("tokens").observeSingleEventAndPreviousSiblingKey(of: .value)
        guard let value = result.0.value as? [String: String] else {
            Logger.log(level: .error, str: "cannot get dictionary from snapshot.value \(String(describing: result.0.value))", shouldLogContext: true)
            
            return Result.failure(NSError(domain: "cannot get dictionary from snapshot.value", code: 0))
        }
        return Result.success(value)
    }
}
