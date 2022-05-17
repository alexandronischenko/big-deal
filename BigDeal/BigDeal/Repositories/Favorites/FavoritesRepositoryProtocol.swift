import Foundation

protocol FavoritesRepositoryProtocol {
    var remoteDataSource: FavoritesRemoteDataSourceProtocol { get }
    var localDataSource: FavoritesLocalDataSourceProtocol { get }
    
    func saveItem(item: Item, completion: (Bool) -> Void)
}
