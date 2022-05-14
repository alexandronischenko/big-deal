import UIKit
import SnapKit

class DetailItemViewController: UIViewController {
    var presenter: DetailItemPresenterProtocol
    var detailItemView = DetailItemView()
    
    init(presenter: DetailItemPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    override func loadView() {
        view = detailItemView
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        detailItemView.delegate = self
        
        // MARK: - FIX IT
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

extension DetailItemViewController: DetailItemViewProtocol {
    func goToShopSite() {
        presenter.buttonPressedGoToShopSite()
    }
    
    func configureModel(model: Item) {
        detailItemView.configureModel(model: model)
        title = model.clothTitle
    }
}
