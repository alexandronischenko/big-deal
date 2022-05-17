import UIKit

protocol FeedMainViewDelegateProtocol: AnyObject {
    func moveToDetailFlow(model: Item)
    func obtainHotProductsFromAsos(with indexPath: IndexPath)
}

class FeedMainView: UIView {
    // MARK: - Private properties
    
    private let reuseIdForItemCell = CustomItemCollectionViewCell.customItemCollectionViewCellReuseId
    // MARK: - Other properties
    
    var data: [Item] = DataManager.shared.itemsForHot
    weak var delegate: FeedMainViewDelegateProtocol?
    // MARK: - UI
    
    let footerView = UIActivityIndicatorView(style: .medium)
    
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
    // MARK: - Overrided
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        collectionView.register(CustomItemCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdForItemCell)
        collectionView.register(HeaderLabel.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "label")

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
            make.centerX.centerY.equalToSuperview()
        }
    }
    // MARK: - Functions
    
    func updateData(data: [Item]) {
        self.data = data
    }
}
// MARK: - UICollectionViewDelegateFlowLayout

extension FeedMainView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: frame.size.width, height: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = data[indexPath.row]
        delegate?.moveToDetailFlow(model: model)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 2.3, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SearchHeaderCollectionReusableView.reuseIdentifierForFooter, for: indexPath)
            footer.addSubview(footerView)
            footerView.frame = CGRect(x: 0, y: 0, width: collectionView.bounds.width, height: 50)
            return footer
        } else {
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "label", for: indexPath) as? HeaderLabel else {
                return UICollectionReusableView()
            }
            sectionHeader.label.text = "TRENDING🔥"
            return sectionHeader
        }
    }
}
// MARK: - UICollectionViewDataSource

extension FeedMainView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdForItemCell, for: indexPath) as? CustomItemCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.data = self.data[indexPath.row]
        if indexPath.item == data.count - 1 {
            delegate?.obtainHotProductsFromAsos(with: indexPath)
        }
        return cell
    }
}
