import UIKit
import Alamofire

protocol SearchMainViewDelegateProtocol: AnyObject {
    func searchMainFilterButtonDidPressed()
    func searchMainCategoryButtonDidPressed(_ sender: UIButton)
    func moveToDetailFlow(model: Item)
    func obtainProductByNameFromAsos(with parameters: Parameters?, headers: HTTPHeaders?, url: URLConvertible)
}

class SearchMainView: UIView {
    var offset: Int = 0
    
    private let reuseIdForItemCell = CustomItemCollectionViewCell.customItemCollectionViewCellReuseId
    
    var data: [Item] = []
    
    weak var delegate: ActivityIndicatorViewDelegateProtocol?
    weak var viewDelegate: SearchMainViewDelegateProtocol?
    
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
//        scrollView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        activityIndicatorView.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
        }
    }
    
    func updateData(data: [Item]) {
        self.data = data
    }
}
// MARK: - UICollectionViewDelegateFlowLayout

extension SearchMainView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: frame.size.width, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = data[indexPath.row]
        viewDelegate?.moveToDetailFlow(model: model)
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
            let offset = UserDefaults.standard.integer(forKey: "offset")
//            activityIndicatorView.startAnimating()
//            viewDelegate?.obtainProductByNameFromAsos(name: "Polo ralph", offset: offset, limit: 10)
//            activityIndicatorView.stopAnimating()
            UserDefaults.standard.set(offset + 10, forKey: "offset")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
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

extension SearchMainView: SearchHeaderCollectionReusableViewDelegateProtocol {
    func searchMainFilterButtonDidPressed() {
        viewDelegate?.searchMainFilterButtonDidPressed()
    }
    func searchMainCategoryButtonDidPressed(_ sender: UIButton) {
        viewDelegate?.searchMainCategoryButtonDidPressed(sender)
    }
}
