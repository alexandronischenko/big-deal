import Foundation

protocol FavoritesDataSourceProtocol: AnyObject {
    func addToFavorites(item: Item, completion: @escaping  (Result<Item, Error>) -> Void)
    
    func obtainFavorites(completion: @escaping  (Result<[Item], Error>) -> Void)
}
