import Foundation

protocol DatabaseManagerProtocol {
    // Function that returnes existing user in database
    func userExists(withEmail email: String, completion: @escaping ((Bool) -> Void))
    
    // Function that insert new user in database
    func insertUser(with user: UserModel)
    
    // Function that delete user by email from database
    func deleteUser(with email: String, completion: @escaping ((Bool) -> Void))
    
    // Function that add favorites to user in database
    func addToFavorites(id: String)
    
    // Function that delete favorite by url user from database
    func deleteFavoritesWith(id: String)
    
    // Function that get user favorites from database
    func getAllFavorites() -> [String]
    
    // Function that checking on containing in firebase favorites
    func isFavorite(id: String) -> Bool
    
    // Function that return user model from firebase
    func getCurrentUserModel(completion: @escaping (Result<UserModel, Error>) -> Void)
}
