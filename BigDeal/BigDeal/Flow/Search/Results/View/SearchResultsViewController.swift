import UIKit
import Alamofire

class SearchResultsViewController: UIViewController {
    // MARK: - Private properties
    
    private var output: SearchResultsPresenterOutputProtocol?
    private let searchResultsView = SearchResultsView()
    
    private let reuseIdForHeaderView = SearchResultsCollectionReusableView.searchResultsCollectionReusableViewId
    private let reuseIdForItemCell = CustomItemCollectionViewCell.customItemCollectionViewCellReuseId
    private let sectionHeader = UICollectionView.elementKindSectionHeader
    // MARK: - Other data and properties
    
    var data: [Item] = DataManager.shared.itemsForCategory
    // MARK: - Initializers
    
    init(output: SearchResultsPresenterOutputProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.output = output
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - View life cycle
    
    override func loadView() {
        view = searchResultsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setUpSearchResultsCollectionView()
        obtainProductByCategoryIdFromAsos()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.tabBarItem.title = UserDefaults.standard.object(forKey: UserDefaultsKeys.keyForCategoryTitle) as? String
    }
    // MARK: - Private functions
    
    private func setUpSearchResultsCollectionView() {
        searchResultsView.searchResultsCollectionView.delegate = self
        searchResultsView.searchResultsCollectionView.dataSource = self
        let cellClass = CustomItemCollectionViewCell.self
        let viewClass = SearchResultsCollectionReusableView.self
        searchResultsView.searchResultsCollectionView.register(cellClass, forCellWithReuseIdentifier: reuseIdForItemCell)
        searchResultsView.searchResultsCollectionView.register(viewClass, forSupplementaryViewOfKind: sectionHeader, withReuseIdentifier: reuseIdForHeaderView)
    }
    
    private func configureView() {
        title = UserDefaults.standard.object(forKey: UserDefaultsKeys.keyForCategoryTitle) as? String
    }
    
    private func obtainProductByCategoryIdFromAsos() {
        guard let categoryId = UserDefaults.standard.object(forKey: UserDefaultsKeys.keyForCategoryId) as? String else {
            return
        }
        let service = ApiServices.accessTokenForCategories.rawValue
        let account = ApiAccounts.asos.rawValue
        guard let accessTokenForAsos = KeychainManager.standard.read(service: service, account: account, type: String.self) else {
            return
        }
        let url = DataManager.shared.asosProductsListUrl
        let parameters: Parameters? = DataManager.shared.obtainParametersForAsosCategory(categoryId)
        let accessTokenHeader = HTTPHeader(name: DataManager.shared.asosAccessTokenHeaderName, value: accessTokenForAsos)
        let headers: HTTPHeaders = [
            DataManager.shared.asosHostHeader,
            accessTokenHeader
        ]
        searchResultsView.activityIndicatorView.startAnimating()
        output?.obtainProductByCategoryFromAsos(with: parameters, headers: headers, url: url)
        DataManager.shared.categoryRepositoryOffset += DataManager.shared.limit
    }
}
// MARK: - UICollectionViewDataSource

extension SearchResultsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdForItemCell, for: indexPath) as? CustomItemCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.data = self.data[indexPath.row]
        if indexPath.item == data.count - 1 {
            obtainProductByCategoryIdFromAsos()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: sectionHeader, withReuseIdentifier: reuseIdForHeaderView, for: indexPath)
        guard let header = header as? SearchResultsCollectionReusableView else {
            return UICollectionReusableView()
        }
        header.delegate = self
        return header
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension SearchResultsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = data[indexPath.row]
        output?.moveToDetailFlow(model: model)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 15, bottom: 10, right: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 2.3, height: 300)
    }
}
// MARK: - SearchResultsReusableViewDelegate
 
extension SearchResultsViewController: SearchResultsReusableViewDelegate {
    func moveToFilterScreen() {
        output?.moveToFilterScreen()
    }
}
// MARK: - SearchResultsPresenterInputProtocol

extension SearchResultsViewController: SearchResultsPresenterInputProtocol {
    func stopAnimating() {
        searchResultsView.activityIndicatorView.stopAnimating()
    }
    
    func startAnimating() {
        searchResultsView.activityIndicatorView.startAnimating()
    }
    
    func reloadCollectionViewData() {
        searchResultsView.searchResultsCollectionView.reloadData()
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
