import Foundation

protocol FavoritesDataSourceProtocol: AnyObject {
    func addToFavorites(item: Item, completion: @escaping  (Result<Bool, Error>) -> Void)
}
