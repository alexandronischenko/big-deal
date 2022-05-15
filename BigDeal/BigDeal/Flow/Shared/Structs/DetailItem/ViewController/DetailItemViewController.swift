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
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let menuBtn = UIButton(type: .custom)
        var img = UIImage(systemName: "heart")
        img = UIImage(systemName: "heart", withConfiguration: UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 100, weight: .medium), scale: .medium))
        menuBtn.setImage(img, for: .normal)
        
        let menuBarItem = UIBarButtonItem(customView: menuBtn)
        let currWidth = menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 26)
        currWidth?.isActive = true
        let currHeight = menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 26)
        currHeight?.isActive = true
        self.navigationItem.rightBarButtonItem = menuBarItem
        
        menuBtn.addTarget(self, action: #selector(didTapAddFavoritesButton), for: .touchUpInside)
    }
}

extension DetailItemViewController: DetailItemViewProtocol {
    func goToShopSite(url: String) {
        guard let url = URL(string: url) else { return }
        UIApplication.shared.open(url)
    }
    
    func configureModel(model: Item) {
        detailItemView.configureModel(model: model)
        title = model.clothTitle
    }
    
    @objc func didTapAddFavoritesButton() {
        guard let url = detailItemView.item?.url else { return }
        presenter.didTapAddToFavorites(url: url)
    }
}
