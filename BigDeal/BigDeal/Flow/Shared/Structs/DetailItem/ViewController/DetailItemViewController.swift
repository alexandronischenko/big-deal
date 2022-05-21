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
        
        navigationController?.navigationBar.prefersLargeTitles = false
        
        let menuBtn = UIButton(type: .custom)
        var img = UIImage(systemName: "heart")
        menuBtn.setImage(img, for: .normal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: menuBtn)
        menuBtn.addTarget(self, action: #selector(didTapAddFavoritesButton(_:)), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.tabBarItem.title = "Detail"
    }
}

extension DetailItemViewController: DetailItemViewProtocol {
    func goToShopSite(url: String) {
        guard let url = URL(string: url) else { return }
        UIApplication.shared.open(url)
    }
    
    func configureModel(model: Item) {
        detailItemView.configureModel(model: model)
    }
    
    @objc func didTapAddFavoritesButton(_ sender: UIButton) {
        presenter.didTapAddToFavorites(model: detailItemView.item!) { isFavorite in
            if isFavorite {
                let menuBtn = UIButton(type: .custom)
                let img = UIImage(systemName: "heart.fill")
                menuBtn.setImage(img, for: .normal)
                let menuBarItem = UIBarButtonItem(customView: menuBtn)
                self.navigationItem.rightBarButtonItem = menuBarItem
                menuBtn.addTarget(self, action: #selector(self.didTapAddFavoritesButton(_:)), for: .touchUpInside)
            } else {
                let menuBtn = UIButton(type: .custom)
                let img = UIImage(systemName: "heart")
                menuBtn.setImage(img, for: .normal)
                let menuBarItem = UIBarButtonItem(customView: menuBtn)
                self.navigationItem.rightBarButtonItem = menuBarItem
                menuBtn.addTarget(self, action: #selector(self.didTapAddFavoritesButton(_:)), for: .touchUpInside)
            }
        }
    }
}
