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
    
    var data: [Item] = []
    
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
        guard let categoryId = UserDefaults.standard.object(forKey: UserDefaultsKeys.keyForCategoryId) as? String else {
            return
        }
        searchResultsView.activityIndicatorView.startAnimating()
        obtainProductByCategoryIdFromAsos(categoryId)
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

extension SearchResultsViewController: SearchResultsReusableViewDelegate {
    func moveToFilterScreen() {
        output?.moveToFilterScreen()
    }
}

// MARK: - SearchResultsPresenterInputProtocol

extension SearchResultsViewController: SearchResultsPresenterInputProtocol {
    func obtainProductByCategoryIdFromAsos(_ categoryId: String) {
        output?.obtainProductByCategoryIdFromAsos(categoryId) { [weak self] response in
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
                    self?.data += items
                    DispatchQueue.main.async {
                        self?.searchResultsView.activityIndicatorView.stopAnimating()
                        self?.searchResultsView.searchResultsCollectionView.reloadData()
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
