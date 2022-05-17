import UIKit

protocol SearchResultsReusableViewDelegate: AnyObject {
    func moveToFilterScreen()
}

class SearchResultsCollectionReusableView: UICollectionReusableView {
    // MARK: - Static properties
    
    static let searchResultsCollectionReusableViewId = "searchResultsCollectionReusableView"
    // MARK: - Properties
    
    weak var delegate: SearchResultsReusableViewDelegate?
    // MARK: - UI
    
    private lazy var searchResultsFilterButton: UIButton = {
        let button = UIButton()
        button.setTitle("Filter", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
        button.sizeToFit()
        button.addTarget(self, action: #selector(searchResultsFilterButtonDidPressed(_:)), for: .touchUpInside)
        return button
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
        searchResultsFilterButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(5)
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    private func setUpSelfView() {
        addSubview(searchResultsFilterButton)
    }
    
    // MARK: - OBJC functions
    
    @objc private func searchResultsFilterButtonDidPressed(_ sender: UIButton) {
        delegate?.moveToFilterScreen()
    }
}
