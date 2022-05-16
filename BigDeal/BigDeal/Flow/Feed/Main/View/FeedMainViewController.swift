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
//        navigationItem.searchController = feedMainView.searchController
        feedMainView.activityIndicatorDelegate = self
        feedMainView.viewDelegate = self
        
//        startAnimating()

//        obtainHotProductsFromAsos()

//        feedMainView.collectionView.reloadData()
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
    func obtainHotProductsFromAsos() {
        output?.obtainHotProductsFromAsos { [weak self] response in
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
                    self?.feedMainView.data += items
                    DispatchQueue.main.async {
                        self?.stopAnimating()
                        self?.feedMainView.collectionView.reloadData()
                    }
                } catch {
                    self?.obtainDataErrorAlert(error: error)
                }
            case .failure(let error):
                self?.resposeResultFailureAlert(with: error)
            }
        }
    }
    func obtainHotProductsFromStockX() {
        output?.obtainHotProductsFromStockX { [weak self] response in
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
                    self?.feedMainView.data += items
                    DispatchQueue.main.async {
                        self?.feedMainView.collectionView.reloadData()
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

extension FeedMainViewController: ActivityIndicatorViewDelegateProtocol {
    func stopAnimating() {
        feedMainView.activityIndicatorView.stopAnimating()
    }
    func startAnimating() {
        feedMainView.activityIndicatorView.startAnimating()
    }
}

extension FeedMainViewController: FeedMainViewDelegateProtocol {
    func moveToDetailFlow(model: Item) {
        self.output?.moveToDetailFlow(model: model)
    }
}
