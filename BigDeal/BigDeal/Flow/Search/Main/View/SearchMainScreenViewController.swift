import UIKit
import Alamofire

class SearchMainViewController: UIViewController {
    var offset: Int = 0
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
        searchMainView.viewDelegate = self
        
        navigationItem.searchController = searchMainView.searchController
        searchMainView.searchController.searchBar.delegate = self
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
    func updateData(data: [Item]) {
        searchMainView.updateData(data: data)
    }
    func obtainProductByNameFromStockX(name: String) {
        output?.obtainProductByNameFromStockX(name: name) { [weak self] response in
            switch response.result {
            case .success:
                do {
                    guard let data = response.data else {
                        self?.dataCollectingErrorAlert()
                        return
                    }
                    let result = try JSONDecoder().decode(StockX.self, from: data)
                    guard let items = Item.getStockXArray(from: result.stockXProducts) else {
                        self?.dataCollectingErrorAlert()
                        return
                    }
                    self?.searchMainView.data += items
                    DispatchQueue.main.async {
                        self?.stopAnimating()
                        self?.searchMainView.collectionView.reloadData()
                    }
                } catch {
                    self?.obtainDataErrorAlert(error: error)
                }
            case .failure(let error):
                self?.resposeResultFailureAlert(with: error)
            }
        }
    }
}
// MARK: - UISearchBarDelegate

extension SearchMainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchMainView.data = []
        guard let searchBarText = searchBar.text else {
            return
        }
        guard  let accessTokenForAsos = KeychainManager.standard.read(service: ApiServices.accessTokenForSearch.rawValue, account: ApiAccounts.asos.rawValue, type: String.self) else {
            return
        }
        let url = DataManager.shared.asosProductsListUrl
        let parameters: Parameters? = DataManager.shared.obtainParametersForAsos(searchBarText, categoryId: nil)
        let accessTokenHeader = HTTPHeader(name: DataManager.shared.asosAccessTokenHeaderName, value: accessTokenForAsos)
        let headers: HTTPHeaders = [
            DataManager.shared.asosHostHeader,
            accessTokenHeader
        ]
//        startAnimating()
        obtainProductByNameFromAsos(with: parameters, headers: headers, url: url)
        offset += 10
        UserDefaults.standard.set(offset, forKey: "offset")
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchMainView.data = []
        DispatchQueue.main.async {
            self.searchMainView.collectionView.reloadData()
        }
        searchBar.resignFirstResponder()
    }
}

extension SearchMainViewController: ActivityIndicatorViewDelegateProtocol {
    func startAnimating() {
        searchMainView.activityIndicatorView.startAnimating()
    }
    func stopAnimating() {
        searchMainView.activityIndicatorView.stopAnimating()
    }
}

extension SearchMainViewController: SearchMainViewDelegateProtocol {
    func moveToDetailFlow(model: Item) {
        self.output?.moveToDetailFlow(model: model)
    }
    
    func searchMainFilterButtonDidPressed() {
        self.output?.searchMainFilterButtonDidPressed()
    }
        
    func searchMainCategoryButtonDidPressed(_ sender: UIButton) {
        self.output?.searchMainCategoryButtonDidPressed(sender)
    }
    
    func obtainProductByNameFromAsos(with parameters: Parameters?, headers: HTTPHeaders?, url: URLConvertible) {
        startAnimating()
        output?.obtainProductByNameFromAsos(with: parameters, headers: headers, url: url) { [weak self] response in
            switch response.result {
            case .success:
                do {
                    guard let data = response.data else {
                        DispatchQueue.main.async {
                            self?.stopAnimating()
                            self?.dataCollectingErrorAlert()
                        }
                        return
                    }
                    let result = try JSONDecoder().decode(Asos.self, from: data)
                    guard let items = Item.getAsosArray(from: result.products) else {
                        DispatchQueue.main.async {
                            self?.stopAnimating()
                            self?.obtainArrayOfItemsAlert()
                        }
                        return
                    }
                    self?.searchMainView.data += items
                    DispatchQueue.main.async {
                        self?.stopAnimating()
                        self?.searchMainView.collectionView.reloadData()
                    }
                } catch {
                    DispatchQueue.main.async {
                        self?.stopAnimating()
                        self?.obtainDataErrorAlert(error: error)
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.stopAnimating()
                    self?.resposeResultFailureAlert(with: error)
                }
            }
        }
    }
}
