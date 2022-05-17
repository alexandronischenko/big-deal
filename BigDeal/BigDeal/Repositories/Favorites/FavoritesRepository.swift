import Foundation

class FavoritesRepository: FavoritesRepositoryProtocol {
    
    // MARK: - Properties
    
    internal let remoteDataSource: FavoritesRemoteDataSourceProtocol
    internal let localDataSource: FavoritesLocalDataSourceProtocol
    
    // MARK: - Initializers
    
    public init(remoteDataSource: FavoritesRemoteDataSourceProtocol, localDataSource: FavoritesLocalDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }
    
    func saveItem(item: Item, completion: (Bool) -> Void) {
        
    }
}
