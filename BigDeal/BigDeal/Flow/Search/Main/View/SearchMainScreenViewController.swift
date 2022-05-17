import UIKit
import Alamofire

class SearchMainViewController: UIViewController {
    // MARK: - Private properties
    
    private let searchMainView = SearchMainView()
    private var output: SearchMainPresenterOutputProtocol?
    // MARK: - Protocol properties
    
    var coordinator: SearchBaseCoordinatorProtocol?
    // MARK: - Initializers
    
    init(output: SearchMainPresenterOutputProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.output = output
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - View life cycle
    
    override func loadView() {
        view = searchMainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Catalog"
        searchMainView.delegate = self
        searchMainView.searchController.searchBar.delegate = self
        navigationItem.searchController = searchMainView.searchController
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.tabBarItem.title = "Catalog"
    }
}
// MARK: - SearchBaseCoordinatedProtocol

extension SearchMainViewController: SearchBaseCoordinatedProtocol {
}
// MARK: - SearchMainPresenterInputProtocol

extension SearchMainViewController: SearchMainPresenterInputProtocol {
    func stopAnimating() {
        searchMainView.activityIndicatorView.stopAnimating()
    }
    
    func startAnimating() {
        searchMainView.activityIndicatorView.startAnimating()
    }
    
    func reloadCollectionViewData() {
        searchMainView.collectionView.reloadData()
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
// MARK: - UISearchBarDelegate

extension SearchMainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        DataManager.shared.items = []
        let service = ApiServices.accessTokenForSearch.rawValue
        let account = ApiAccounts.asos.rawValue
        guard let searchBarText = searchBar.text, let accessTokenForAsos = KeychainManager.standard.read(service: service, account: account, type: String.self) else {
            return
        }
        let url = DataManager.shared.asosProductsListUrl
        let parameters: Parameters? = DataManager.shared.obtainParametersForAsos(searchBarText, categoryId: nil)
        let accessTokenHeader = HTTPHeader(name: DataManager.shared.asosAccessTokenHeaderName, value: accessTokenForAsos)
        let headers: HTTPHeaders = [
            DataManager.shared.asosHostHeader,
            accessTokenHeader
        ]
        startAnimating()
        output?.obtainProductByNameFromAsos(with: parameters, headers: headers, url: url)
        DataManager.shared.offset += DataManager.shared.limit
        DataManager.shared.currentSearchingItemText = searchBarText
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        DataManager.shared.items = []
        DispatchQueue.main.async {
            self.reloadCollectionViewData()
            self.searchMainView.footerView.stopAnimating()
        }
        searchBar.resignFirstResponder()
    }
}
// MARK: - SearchMainViewDelegateProtocol

extension SearchMainViewController: SearchMainViewDelegateProtocol {
    // Functions
    
    func moveToDetailFlow(model: Item) {
        self.output?.moveToDetailFlow(model: model)
    }
    
    func searchMainFilterButtonDidPressed() {
        self.output?.searchMainFilterButtonDidPressed()
    }
        
    func searchMainCategoryButtonDidPressed(_ sender: UIButton) {
        self.output?.searchMainCategoryButtonDidPressed(sender)
    }
    
    func obtainProductByNameFromAsos() {
        let service = ApiServices.accessTokenForSearch.rawValue
        let account = ApiAccounts.asos.rawValue
        guard let accessTokenForAsos = KeychainManager.standard.read(service: service, account: account, type: String.self) else {
            return
        }
        let url = DataManager.shared.asosProductsListUrl
        let searchingProduct = DataManager.shared.currentSearchingItemText
        let parameters: Parameters? = DataManager.shared.obtainParametersForAsos(searchingProduct, categoryId: nil)
        let accessTokenHeader = HTTPHeader(name: DataManager.shared.asosAccessTokenHeaderName, value: accessTokenForAsos)
        let headers: HTTPHeaders = [
            DataManager.shared.asosHostHeader,
            accessTokenHeader
        ]
        searchMainView.footerView.startAnimating()
        output?.obtainProductByNameFromAsos(with: parameters, headers: headers, url: url)
    }
}
