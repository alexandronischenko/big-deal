import UIKit

protocol SearchHeaderCollectionReusableViewDelegateProtocol: AnyObject {
    func searchMainFilterButtonDidPressed()
    func searchMainCategoryButtonDidPressed(_ sender: UIButton)
}

class SearchHeaderCollectionReusableView: UICollectionReusableView {
    // MARK: - Static properties
    
    static let reuseIdentifierForHeader = "HeaderCollectionReusableView"
    static let reuseIdentifierForFooter = "FooterCollectionReusableView"
    // MARK: - Other properties
    
    weak var delegate: SearchHeaderCollectionReusableViewDelegateProtocol?
    // MARK: - UI
    
    lazy var filterButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("Filter", for: .normal)
        button.setTitle("Filter", for: .highlighted)
        button.layer.cornerRadius = 6
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        button.addTarget(self, action: #selector(searchMainFilterButtonDidPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var outerwearButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = .systemGray2
        button.setTitle("Outerwear", for: .normal)
        button.setTitle("Outerwear", for: .highlighted)
        button.layer.cornerRadius = 6
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        button.addTarget(self, action: #selector(searchMainCategoryButtonDidPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var sweatshirtsButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = .systemGray2
        button.setTitle("Sweatshirts", for: .normal)
        button.setTitle("Sweatshirts", for: .highlighted)
        button.layer.cornerRadius = 6
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        button.addTarget(self, action: #selector(searchMainCategoryButtonDidPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var shirtsButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = .systemGray2
        button.setTitle("T-shirts and tops", for: .normal)
        button.setTitle("T-shirts and tops", for: .highlighted)
        button.layer.cornerRadius = 6
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        button.addTarget(self, action: #selector(searchMainCategoryButtonDidPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var sneakersButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = .systemGray2
        button.setTitle("Sneakers", for: .normal)
        button.setTitle("Sneakers", for: .highlighted)
        button.layer.cornerRadius = 6
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        button.addTarget(self, action: #selector(searchMainCategoryButtonDidPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var perfumeButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = .systemGray2
        button.setTitle("Perfume", for: .normal)
        button.setTitle("Perfume", for: .highlighted)
        button.layer.cornerRadius = 6
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        button.addTarget(self, action: #selector(searchMainCategoryButtonDidPressed), for: .touchUpInside)
        return button
    }()
    
    let upStackView: UIStackView = {
        var view = UIStackView()
        return view
    }()
    
    let downStackView: UIStackView = {
        var view = UIStackView()
        return view
    }()
    // MARK: - Overrided
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        upStackView.addArrangedSubview(filterButton)
        upStackView.addArrangedSubview(outerwearButton)
        upStackView.addArrangedSubview(sweatshirtsButton)
        
        downStackView.addArrangedSubview(shirtsButton)
        downStackView.addArrangedSubview(sneakersButton)
        downStackView.addArrangedSubview(perfumeButton)

        addSubview(upStackView)
        addSubview(downStackView)
        
        upStackView.spacing = 8
        upStackView.distribution = .fillProportionally
        upStackView.alignment = .center
        upStackView.axis = .horizontal
        
        downStackView.spacing = 8
        downStackView.distribution = .fillProportionally
        downStackView.alignment = .center
        downStackView.axis = .horizontal
        
        upStackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        downStackView.snp.makeConstraints { make in
            make.top.equalTo(upStackView.snp.bottom).offset(8)
            make.leading.trailing.equalTo(upStackView)
        }
    }
    // MARK: - OBJC functions
    
    @objc private func searchMainFilterButtonDidPressed(_ sender: UIButton) {
        delegate?.searchMainFilterButtonDidPressed()
    }
    
    @objc private func searchMainCategoryButtonDidPressed(_ sender: UIButton) {
        delegate?.searchMainCategoryButtonDidPressed(sender)
    }
}
