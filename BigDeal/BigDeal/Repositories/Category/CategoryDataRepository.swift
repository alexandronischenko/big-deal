import Foundation

class CategoryDataRepository: CategoryRepositoryProtocol {    
    // MARK: - Private properties
    
    private let remoteDataSource: CategoryRemoteDataSourceProtocol
    private let localDataSource: CategoryLocalDataSourceProtocol
    
    // MARK: - Initializers
 
    public init(remoteDataSource: CategoryRemoteDataSourceProtocol, localDataSource: CategoryLocalDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }
}
