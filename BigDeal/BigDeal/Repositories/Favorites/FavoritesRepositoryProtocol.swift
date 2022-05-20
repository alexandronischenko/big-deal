import Foundation

protocol FavoritesRepositoryProtocol {
    func save(item: Item, completion: @escaping (Result<Bool, Error>) -> Void)
}
