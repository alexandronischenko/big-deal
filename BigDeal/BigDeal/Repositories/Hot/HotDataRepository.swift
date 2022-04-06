import Foundation

class HotDataRepository: HotRepositoryProtocol {
    
    // MARK: - Private properties
    
    private let remoteDataSource: HotRemoteDataSourceProtocol
    private let localDataSource: HotLocalDataSourceProtocol
    
    // MARK: - Initializers
    
    public init(remoteDataSource: HotRemoteDataSourceProtocol, localDataSource: HotLocalDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }
}
