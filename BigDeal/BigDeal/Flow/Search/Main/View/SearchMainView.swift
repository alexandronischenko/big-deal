import UIKit
import Alamofire

protocol SearchMainViewDelegateProtocol: AnyObject {
    func searchMainFilterButtonDidPressed()
    func searchMainCategoryButtonDidPressed(_ sender: UIButton)
    func moveToDetailFlow(model: Item)
    func obtainProductByNameFromAsos(with parameters: Parameters?, headers: HTTPHeaders?, url: URLConvertible)
}

class SearchMainView: UIView {
    // MARK: - Private properties
    
    let footerView = UIActivityIndicatorView(style: .medium)
    private let reuseIdForItemCell = CustomItemCollectionViewCell.customItemCollectionViewCellReuseId
    
    // MARK: - Other properties
    
    var data: [Item] = []
    weak var delegate: SearchMainViewDelegateProtocol?
    
    // MARK: - UI
    
    lazy var activityIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.hidesWhenStopped = true
        view.color = .label
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "Footer")
        return collectionView
    }()
    
    var scrollView: UIScrollView = {
        var scroll = UIScrollView()
        scroll.clipsToBounds = true
        return scroll
    }()
    
    var searchController: UISearchController = {
        var controller = UISearchController()
        return controller
    }()

    var button: UIButton = {
        var button = UIButton(type: .system)
        button.setTitle("Зарегистрироваться", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 6
        return button
    }()
    // MARK: - Overrided
    
    // Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        collectionView.register(
            SearchHeaderCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SearchHeaderCollectionReusableView.identifier)
        collectionView.register(CustomItemCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdForItemCell)
        collectionView.delegate = self
        collectionView.dataSource = self
        addSubview(collectionView)
        addSubview(activityIndicatorView)
        layoutSubviews()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        activityIndicatorView.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
        }
    }
    // MARK: - Functions
    
    func updateData(data: [Item]) {
        self.data = data
    }
}
// MARK: - UICollectionViewDelegateFlowLayout

extension SearchMainView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: frame.size.width, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: frame.size.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = data[indexPath.row]
        delegate?.moveToDetailFlow(model: model)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 15, bottom: 10, right: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 2.3, height: 300)
    }
}
// MARK: - UICollectionViewDataSource

extension SearchMainView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdForItemCell, for: indexPath) as? CustomItemCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.data = self.data[indexPath.row]
        if indexPath.item == data.count - 1 {
            let service = ApiServices.accessTokenForSearch.rawValue
            let account = ApiAccounts.asos.rawValue
            guard let accessTokenForAsos = KeychainManager.standard.read(service: service, account: account, type: String.self) else {
                return UICollectionViewCell()
            }
            let url = DataManager.shared.asosProductsListUrl
            let searchingProduct = DataManager.shared.currentSearchingItemText
            let parameters: Parameters? = DataManager.shared.obtainParametersForAsos(searchingProduct, categoryId: nil)
            let accessTokenHeader = HTTPHeader(name: DataManager.shared.asosAccessTokenHeaderName, value: accessTokenForAsos)
            let headers: HTTPHeaders = [
                DataManager.shared.asosHostHeader,
                accessTokenHeader
            ]
            footerView.startAnimating()
            delegate?.obtainProductByNameFromAsos(with: parameters, headers: headers, url: url)
            DataManager.shared.offset += DataManager.shared.limit
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Footer", for: indexPath)
            footer.addSubview(footerView)
            footerView.frame = CGRect(x: 0, y: 0, width: collectionView.bounds.width, height: 50)
            return footer
        } else {
            guard let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: SearchHeaderCollectionReusableView.identifier,
                for: indexPath) as? SearchHeaderCollectionReusableView else {
                return UICollectionReusableView()
            }
            header.delegate = self
            return header
        }
    }
}
// MARK: - SearchHeaderCollectionReusableViewDelegateProtocol

extension SearchMainView: SearchHeaderCollectionReusableViewDelegateProtocol {
    func searchMainFilterButtonDidPressed() {
        delegate?.searchMainFilterButtonDidPressed()
    }
    func searchMainCategoryButtonDidPressed(_ sender: UIButton) {
        delegate?.searchMainCategoryButtonDidPressed(sender)
    }
}
