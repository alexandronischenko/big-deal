import Foundation
import UIKit

class ProductDataRepository: ProductRepositoryProtocol {
    // MARK: - Private properties
    
    private let remoteDataSource: ProductRemoteDataSourceProtocol
    private let localDataSource: ProductLocalDataSourceProtocol
    
    // MARK: - Initializers
    
    public init(remoteDataSource: ProductRemoteDataSourceProtocol, localDataSource: ProductLocalDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }
}
