import UIKit
import Alamofire

class FeedMainViewController: UIViewController {
    // MARK: - Private properties
    
    private let feedMainView = FeedMainView()
    private var output: FeedMainPresenterOutputProtocol?
    // MARK: - Protocol properties
    
    var coordinator: FeedBaseCoordinatorProtocol?
    // MARK: - Initializers
    
    init(output: FeedMainPresenterOutputProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.output = output
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - View life cycle
    
    override func loadView() {
        view = feedMainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Feed"
        feedMainView.delegate = self
        UserDefaults.standard.set(Category.outwear.rawValue, forKey: UserDefaultsKeys.keyForHot)
        obtainHotProductsFromAsos(with: IndexPath(item: 0, section: 0))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.tabBarItem.title = "Main"
    }
}
// MARK: - FeedBaseCoordinatedProtocol

extension FeedMainViewController: FeedBaseCoordinatedProtocol {
}
// MARK: - FeedMainPresenterInputProtocol

extension FeedMainViewController: FeedMainPresenterInputProtocol {
    func updateData(data: [Item]) {
        feedMainView.updateData(data: data)
    }
    
    func stopAnimating() {
        feedMainView.activityIndicatorView.stopAnimating()
    }
    
    func startAnimating() {
        feedMainView.activityIndicatorView.startAnimating()
    }
    
    func reloadCollectionViewData() {
        feedMainView.collectionView.reloadData()
    }
    
    func dataCollectingErrorAlert() {
        AlertManager.standard.dataCollectingErrorAlert(view: self)
    }
    
    func obtainArrayOfItemsAlert() {
        AlertManager.standard.obtainArrayOfItemsAlert(view: self)
    }
    
    func resposeResultFailureAlert(with error: AFError) {
        AlertManager.standard.resposeResultFailureAlert(with: error, view: self)
    }
    
    func obtainDataErrorAlert(error: Error) {
        AlertManager.standard.obtainDataErrorAlert(error: error, view: self)
    }
}
// MARK: - FeedMainViewDelegateProtocol

extension FeedMainViewController: FeedMainViewDelegateProtocol {
    func moveToDetailFlow(model: Item) {
        self.output?.moveToDetailFlow(model: model)
    }
    
    func obtainHotProductsFromAsos(with indexPath: IndexPath) {
        let service = ApiServices.accessTokenForFeed.rawValue
        let account = ApiAccounts.asos.rawValue
        let object = UserDefaults.standard.object(forKey: UserDefaultsKeys.keyForHot)
        guard let accessTokenForAsos = KeychainManager.standard.read(service: service, account: account, type: String.self), let categoryId = object as? String else {
            return
        }
        let url = DataManager.shared.asosProductsListUrl
        let parameters: Parameters? = DataManager.shared.obtainParametersForAsosCategory(categoryId)
        let accessTokenHeader = HTTPHeader(name: DataManager.shared.asosAccessTokenHeaderName, value: accessTokenForAsos)
        let headers: HTTPHeaders = [
            DataManager.shared.asosHostHeader,
            accessTokenHeader
        ]
        if indexPath.item == DataManager.shared.itemsForHot.count - 1 {
            feedMainView.footerView.startAnimating()
        } else {
            startAnimating()
        }
        output?.obtainHotProductsFromAsos(with: parameters, headers: headers, url: url)
        DataManager.shared.hotRepositoryOffset += DataManager.shared.limit
    }
}
