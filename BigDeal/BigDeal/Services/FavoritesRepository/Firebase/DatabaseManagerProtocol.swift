import Foundation

protocol DatabaseManagerProtocol {
    // Function that returnes existing user in database
    func userExists(withEmail email: String, completion: @escaping ((Bool) -> Void))
    
    // Function that insert new user in database
    func insertUser(with user: UserModel)
    
    // Function that add favorites to user in database
    func addToFavorites(model: Item, completion: @escaping (Result<Item, Error>) -> Void)
    
    // Function that delete favorite by url user from database
    func deleteFromFavorites(model: Item, completion: @escaping (Result<Bool, Error>) -> Void)
    
    // Function that get user favorites from database
    func getAllFavorites(completion: @escaping (Result<[Item], Error>) -> Void)
    
    // Function that checking on containing in firebase favorites
    func isFavorite(model: Item, completion: @escaping (Result<Bool, Error>) -> Void)
    
    // Function that return user model from firebase
    func getCurrentUserModel(completion: @escaping (Result<UserModel, Error>) -> Void)
}
