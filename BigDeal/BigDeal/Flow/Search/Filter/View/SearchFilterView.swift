import UIKit

protocol SearchFilterViewDelegate: AnyObject {
    func dismissFilterView()
}

class SearchFilterView: UIView {
    // MARK: - Properties
    
    weak var delegate: SearchFilterViewDelegate?
    
    lazy var searchFilterTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private lazy var searchFilterApplyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Apply", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(searchFilterApplyButtonDidPressed), for: .touchUpInside)
        button.sizeToFit()
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
        backgroundColor = .systemBackground
        setUpSelfView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private functions
    
    private func setUpSelfView() {
        addSubview(searchFilterTableView)
        addSubview(searchFilterApplyButton)
    }
    
    private func setUpConstraintsForViews() {
        searchFilterApplyButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(16)
        }
        searchFilterTableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalTo(searchFilterApplyButton).inset(45)
        }
    }
    
    @objc func searchFilterApplyButtonDidPressed() {
        delegate?.dismissFilterView()
    }
}
