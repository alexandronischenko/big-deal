import UIKit

class SearchHeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "HeaderCollectionReusableView"
    
    let filterButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("Filter", for: .normal)
        button.setTitle("Filter", for: .highlighted)
        button.layer.cornerRadius = 6
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        return button
    }()
    
    let outerwearButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = .systemGray2
        button.setTitle("Outerwear", for: .normal)
        button.setTitle("Outerwear", for: .highlighted)
        button.layer.cornerRadius = 6
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        return button
    }()
    
    let sweatshirtsButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = .systemGray2
        button.setTitle("Sweatshirts", for: .normal)
        button.setTitle("Sweatshirts", for: .highlighted)
        button.layer.cornerRadius = 6
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        return button
    }()
    
    let shirtsButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = .systemGray2
        button.setTitle("T-shirts and tops", for: .normal)
        button.setTitle("T-shirts and tops", for: .highlighted)
        button.layer.cornerRadius = 6
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        return button
    }()
    
    let sneakersButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = .systemGray2
        button.setTitle("Sneakers", for: .normal)
        button.setTitle("Sneakers", for: .highlighted)
        button.layer.cornerRadius = 6
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        return button
    }()
    
    let perfumeButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = .systemGray2
        button.setTitle("Perfume", for: .normal)
        button.setTitle("Perfume", for: .highlighted)
        button.layer.cornerRadius = 6
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
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
}
