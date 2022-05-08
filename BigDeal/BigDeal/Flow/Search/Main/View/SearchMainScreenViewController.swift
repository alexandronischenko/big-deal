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
        title = "Сatalog"
        
        navigationItem.searchController = searchMainView.searchController
        searchMainView.searchController.searchBar.delegate = self
        
        let accessTokenForAsosSearch = DataManager.shared.accessTokensForAsos["tokenForSearch"]
        let accessTokenForStockXSearch = DataManager.shared.accessTokensForStockX["tokenForSearch"]
        let accessTokenForStockXFarfetch = DataManager.shared.accessTokensForFarfetch["tokenForSearch"]
        
        KeychainManager.standard.save(accessTokenForAsosSearch, service: ApiServices.accessToken.rawValue, account: ApiAccounts.asos.rawValue)
        KeychainManager.standard.save(accessTokenForStockXSearch, service: ApiServices.accessToken.rawValue, account: ApiAccounts.stockX.rawValue)
        KeychainManager.standard.save(accessTokenForStockXFarfetch, service: ApiServices.accessToken.rawValue, account: ApiAccounts.farfetch.rawValue)
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
    func obtainProductByNameFromAsos(name: String) {
        output?.obtainProductByNameFromAsos(name: name) { [weak self] response in
            switch response.result {
            case .success:
                do {
                    guard let data = response.data else {
                        self?.dataCollectingErrorAlert() 
                        return
                    }
                    let result = try JSONDecoder().decode(Asos.self, from: data)
                    guard let items = Item.getAsosArray(from: result.products) else {
                        self?.dataCollectingErrorAlert()
                        return
                    }
                    self?.searchMainView.data += items
                    DispatchQueue.main.async {
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
                    guard let items = Item.getStockXArray(from: result.stockXData.stockXItems) else {
                        self?.dataCollectingErrorAlert()
                        return
                    }
                    self?.searchMainView.data += items
                    DispatchQueue.main.async {
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
    func obtainProductByNameFromFarfetch(name: String) {
        output?.obtainProductByNameFromFarfetch(name: name) { [weak self] response in
            switch response.result {
            case .success:
                do {
                    guard let data = response.data else {
                        self?.dataCollectingErrorAlert()
                        return
                    }
                    let result = try JSONDecoder().decode(Farfetch.self, from: data)
                    guard let items = Item.getFarfetchArray(from: result.products.entries) else {
                        self?.dataCollectingErrorAlert()
                        return
                    }
                    self?.searchMainView.data += items
                    DispatchQueue.main.async {
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
    func dataCollectingErrorAlert() {
        guard let collectingError = String?(ErrorsDescriptions.collectingError.rawValue) else {
            return
        }
        let alertController = UIAlertController(title: "Data collecting error❗️", message: collectingError, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default) { _ in
            self.dismiss(animated: true, completion: nil)
        })
        self.present(alertController, animated: true, completion: nil)
    }
    func resposeResultFailureAlert(with error: AFError) {
        let alertController = UIAlertController(title: "Failure during request❗️", message: error.localizedDescription, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default) { _ in
            self.dismiss(animated: true, completion: nil)
        })
        self.present(alertController, animated: true, completion: nil)
    }
    func obtainDataErrorAlert(error: Error) {
        let alertController = UIAlertController(title: "Data processing error❗️", message: error.localizedDescription, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default) { _ in
            self.dismiss(animated: true, completion: nil)
        })
        self.present(alertController, animated: true, completion: nil)
    }
}
// MARK: - UISearchBarDelegate

extension SearchMainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchBarText = searchBar.text else {
            return
        }
        obtainProductByNameFromAsos(name: searchBarText)
//        obtainProductByNameFromStockX(name: searchBarText )
        print(self.searchMainView.data)
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
