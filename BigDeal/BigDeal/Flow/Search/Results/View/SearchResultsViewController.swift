import UIKit
import Alamofire

class SearchResultsViewController: UIViewController {
    // MARK: - Private properties
    
    private var output: SearchResultsPresenterOutputProtocol?
    private let searchResultsView = SearchResultsView()
    
    private let reuseIdForFooterView = SearchResultsCollectionReusableView.footerReuseId
    private let reuseIdForItemCell = CustomItemCollectionViewCell.customItemCollectionViewCellReuseId
    private let sectionFooter = UICollectionView.elementKindSectionFooter
    // MARK: - Other data and properties
    
    var data: [Item] = []
    var dataForSearchByFilters: [Item] = []
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
        DataManager.shared.itemsForCategory = []
        DataManager.shared.itemsForFilters = []
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let isSearchByFilters = UserDefaults.standard.bool(forKey: "isSearchByFilters")
        if !isSearchByFilters {
            navigationController?.tabBarItem.title = UserDefaults.standard.object(forKey: UserDefaultsKeys.keyForCategoryTitle) as? String
            obtainProductByCategoryIdFromAsos(with: IndexPath(item: 0, section: 0))
        } else {
            navigationController?.tabBarItem.title = "Men's sale"
        }
    }
    // MARK: - Private functions
    
    private func setUpSearchResultsCollectionView() {
        searchResultsView.searchResultsCollectionView.delegate = self
        searchResultsView.searchResultsCollectionView.dataSource = self
        let cellClass = CustomItemCollectionViewCell.self
        let viewClass = SearchResultsCollectionReusableView.self
        searchResultsView.searchResultsCollectionView.register(cellClass, forCellWithReuseIdentifier: reuseIdForItemCell)
        searchResultsView.searchResultsCollectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: sectionFooter, withReuseIdentifier: reuseIdForFooterView)
    }
    
    private func configureView() {
        let isSearchByFilters = UserDefaults.standard.bool(forKey: "isSearchByFilters")
        if isSearchByFilters {
            title = UserDefaults.standard.object(forKey: "titleForFiltersSearch") as? String
        } else {
            title = UserDefaults.standard.object(forKey: UserDefaultsKeys.keyForCategoryTitle) as? String
        }
    }
    
    private func obtainProductByCategoryIdFromAsos(with indexPath: IndexPath) {
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
        if indexPath.item == data.count - 1 {
            searchResultsView.footerView.startAnimating()
        } else {
            startAnimating()
        }
        output?.obtainProductByCategoryFromAsos(with: parameters, headers: headers, url: url)
        DataManager.shared.categoryRepositoryOffset += DataManager.shared.limit
    }
}
// MARK: - UICollectionViewDataSource

extension SearchResultsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let isSearchByFilters = UserDefaults.standard.bool(forKey: "isSearchByFilters")
        if isSearchByFilters {
            dataForSearchByFilters = DataManager.shared.itemsForFilters
            return dataForSearchByFilters.count
        } else {
            data = DataManager.shared.itemsForCategory
            return data.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        data = DataManager.shared.itemsForCategory
        dataForSearchByFilters = DataManager.shared.itemsForFilters
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdForItemCell, for: indexPath) as? CustomItemCollectionViewCell else {
            return UICollectionViewCell()
        }
        let isSearchByFilters = UserDefaults.standard.bool(forKey: "isSearchByFilters")
        if isSearchByFilters {
            cell.data = self.dataForSearchByFilters[indexPath.item]
            if indexPath.item == dataForSearchByFilters.count - 1 {
                output?.loadNewData(by: indexPath)
            }
            return cell
        } else {
            cell.data = self.data[indexPath.item]
            if indexPath.item == data.count - 1 {
                obtainProductByCategoryIdFromAsos(with: indexPath)
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: reuseIdForFooterView, for: indexPath)
            footer.addSubview(searchResultsView.footerView)
            searchResultsView.footerView.frame = CGRect(x: 0, y: 0, width: collectionView.bounds.width, height: 50)
            return footer
    }
}
// MARK: - UICollectionViewDelegateFlowLayout

extension SearchResultsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let isSearchByFilters = UserDefaults.standard.bool(forKey: "isSearchByFilters")
        if isSearchByFilters {
            dataForSearchByFilters = DataManager.shared.itemsForFilters
            let model = dataForSearchByFilters[indexPath.row]
            output?.moveToDetailFlow(model: model)
        } else {
            data = DataManager.shared.itemsForCategory
            let model = data[indexPath.row]
            output?.moveToDetailFlow(model: model)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.size.width, height: 50)
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
    func animateSearchResultsView() {
        searchResultsView.footerView.startAnimating()
    }
    
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
