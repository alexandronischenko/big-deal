import UIKit
import Alamofire

protocol SearchMainViewDelegateProtocol: AnyObject {
    func searchMainFilterButtonDidPressed()
    func searchMainCategoryButtonDidPressed(_ sender: UIButton)
    func moveToDetailFlow(model: Item)
    func obtainProductByNameFromAsos()
}

class SearchMainView: UIView {
    // MARK: - Private properties
    
    private let reuseIdForItemCell = CustomItemCollectionViewCell.customItemCollectionViewCellReuseId
    
    // MARK: - Other properties
    
    var data: [Item] = DataManager.shared.items
    weak var delegate: SearchMainViewDelegateProtocol?
    // MARK: - UI
    
    let footerView = UIActivityIndicatorView(style: .medium)
    
    lazy var activityIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
        view.hidesWhenStopped = true
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: SearchHeaderCollectionReusableView.reuseIdentifierForFooter)
        return collectionView
    }()
    
    lazy var searchController: UISearchController = {
        var controller = UISearchController()
        return controller
    }()

    // MARK: - Overrided
    
    // Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        collectionView.register(
            SearchHeaderCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SearchHeaderCollectionReusableView.identifierForHeader)
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
            delegate?.obtainProductByNameFromAsos()
            DataManager.shared.offset += DataManager.shared.limit
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SearchHeaderCollectionReusableView.reuseIdentifierForFooter, for: indexPath)
            footer.addSubview(footerView)
            footerView.frame = CGRect(x: 0, y: 0, width: collectionView.bounds.width, height: 50)
            return footer
        } else {
            guard let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: SearchHeaderCollectionReusableView.reuseIdentifierForHeader,
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
