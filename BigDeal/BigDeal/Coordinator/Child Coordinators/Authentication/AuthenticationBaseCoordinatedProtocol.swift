import Foundation

protocol AuthenticationBaseCoordinatedProtocol {
    
    // MARK: - Properties
    
    var coordinator: AuthenticationBaseCoordinatorProtocol? { get set }
}
