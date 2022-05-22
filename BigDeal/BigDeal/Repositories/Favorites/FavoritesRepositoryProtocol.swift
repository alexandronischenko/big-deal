import Foundation

protocol FavoritesRepositoryProtocol {
    func save(item: Item, completion: @escaping (Result<Bool, Error>) -> Void)
    
    func obtainAll(completion: @escaping (Result<[Item], Error>) -> Void)
}
