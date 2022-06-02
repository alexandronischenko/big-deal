import UIKit

class DetailItemBuilder {    
    let coordinator: FlowCoordinatorProtocol
    init(coordinator: FlowCoordinatorProtocol) {
        self.coordinator = coordinator
    }

    func build(model: Item) -> UIViewController {
        let repository = FavoritesRepository(remoteDataSource: FavoritesRemoteDataSource(), localDataSource: FavoritesLocalDataSource())
        
        let presenter = DetailItemPresenter(coordinator: coordinator, model: model, repository: repository)
        let viewContoller = DetailItemViewController(presenter: presenter)
        presenter.view = viewContoller
        presenter.configureModel(model: model)
        return viewContoller
    }
}
