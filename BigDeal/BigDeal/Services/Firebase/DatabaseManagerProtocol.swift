import Foundation

protocol DatabaseManagerProtocol {
    // Function that returnes existing user in database
    func userExists(with email: String, completion: @escaping ((Bool) -> Void))
    
    // Function that insert new user in database
    func insertUser(with user: UserModel)
    
    // Function that delete user by email from database
    func deleteUser(with email: String, completion: @escaping ((Bool) -> Void))
    
    // Function that add favorites to user in database
    func addFavorites(_ url: String, toUser email: String)
    
    // Function that delete favorite by url user from database
    func deleteFavoritesWith(url: String, from email: String)
}
