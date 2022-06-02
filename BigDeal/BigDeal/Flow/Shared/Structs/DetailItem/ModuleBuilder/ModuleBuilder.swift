import UIKit

class DetailItemBuilder {
    // MARK: - Properties
    
    let coordinator: FlowCoordinatorProtocol
    // MARK: - Initializers
    
    init(coordinator: FlowCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    // MARK: - Fucntions

    func build(model: Item) -> UIViewController {
        let repository = FavoritesRepository(remoteDataSource: FavoritesRemoteDataSource(), localDataSource: FavoritesLocalDataSource())
        
        let presenter = DetailItemPresenter(coordinator: coordinator, model: model, repository: repository)
        let viewContoller = DetailItemViewController(presenter: presenter)
        presenter.view = viewContoller
        presenter.configureModel(model: model)
        return viewContoller
    }
}
