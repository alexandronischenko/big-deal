import UIKit

class ProfileMainView: UIView {
    // MARK: - Properties
    
    lazy var profileMainCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        return collectionView
    }()
    
    // MARK: - Overrided
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileMainCollectionView.frame = self.bounds
    }
    
    // Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpSelfView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private funcs
    
    private func setUpSelfView() {
        addSubview(profileMainCollectionView)
    }
}
