import Foundation

protocol CoreDataManagerProtocol: AnyObject {
    // Function that add favorites to user in database
    func addToFavorites(model: Item, completion: @escaping (Result<Bool, Error>) -> Void)
    
    // Function that delete favorite by url user from database
    func deleteFromFavorites(model: Item, completion: @escaping (Result<Bool, Error>) -> Void)
    
    // Function that get user favorites from database
    func getAllFavorites(completion: @escaping (Result<[Item], Error>) -> Void)
    
    // Function that checking on containing in favorites
    func isFavorite(model: Item, completion: @escaping (Result<Bool, Error>) -> Void)
}
