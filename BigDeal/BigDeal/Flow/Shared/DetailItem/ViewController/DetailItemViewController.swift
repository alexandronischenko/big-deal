import UIKit
import SnapKit

protocol DetailItemViewPresenterProtocol {
    func goToShopSite()
}

class DetailItemViewController: UIViewController {
    var presenter: DetailItemViewPresenterProtocol
    var detailItemView = DetailItemView()
    var model: Item
    
    init(presenter: DetailItemViewPresenterProtocol, model: Item) {
        self.presenter = presenter
        self.model = model
        super.init(nibName: nil, bundle: nil)

        title = model.clothTitle

        configureView()
    }

    func configureView() {
        detailItemView.sizesLabel.text = model.sizes.joined(separator: " ")
        detailItemView.currentPriceLabel.text = model.newPrice
        detailItemView.defaultPriceLabel.text = model.oldPrice
        detailItemView.imageView.image = model.clothImage
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
        title = "krossovrki"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

extension DetailItemViewController: DetailItemViewProtocol {
    func goToShopSite() {
        presenter.goToShopSite()
    }
}
