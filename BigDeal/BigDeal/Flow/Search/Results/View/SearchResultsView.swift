import UIKit

class SearchResultsView: UIView {
    // MARK: - Properties
    
    lazy var searchResultsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        return collectionView
    }()
    
    // MARK: - Overrided
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUpConstraintsForViews()
    }
    
    // Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpSelfView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private functions
    
    private func setUpConstraintsForViews() {
        searchResultsCollectionView.frame = self.bounds
    }
    
    private func setUpSelfView() {
        addSubview(searchResultsCollectionView)
    }
}
