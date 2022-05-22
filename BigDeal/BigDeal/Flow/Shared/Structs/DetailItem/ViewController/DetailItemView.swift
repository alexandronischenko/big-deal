import UIKit

protocol DetailItemViewProtocol: AnyObject {
    func goToShopSite(url: String)
    func configureModel(model: Item)
}

class DetailItemView: UIView {
    weak var delegate: DetailItemViewProtocol?
    
    var item: Item?
    
    var scrollView: UIScrollView = {
        var scroll = UIScrollView()
        scroll.showsVerticalScrollIndicator = false
        scroll.showsHorizontalScrollIndicator = false
        return scroll
    }()
    
    var largeLabel: UILabel = {
        var label = UILabel()
        label.text = "Name Name Name Name Name Name Name Name"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    var shop: UILabel = {
        var label = UILabel()
        label.text = "Category:"
        label.textColor = .tertiaryLabel
        return label
    }()
    
    var name: UILabel = {
        var label = UILabel()
        label.text = "Name:"
        label.textColor = .tertiaryLabel
        return label
    }()
    
    var defaultPrice: UILabel = {
        var label = UILabel()
        label.text = "Default price:"
        label.textColor = .tertiaryLabel
        return label
    }()
    
    var currentPrice: UILabel = {
        var label = UILabel()
        label.text = "Discount price:"
        label.textColor = .tertiaryLabel
        return label
    }()
    
    var imageView: UIImageView = {
        var image = UIImage(systemName: "bag")
        var imageView = UIImageView(image: image)
        imageView.tintColor = .label
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var shopNameLabel: UILabel = {
        var label = UILabel()
        label.text = "none"
        label.textColor = .label
        label.textAlignment = .right
        return label
    }()
    
    var nameLabel: UILabel = {
        var label = UILabel()
        label.textColor = .label
        label.textAlignment = .right
        label.text = "none"
        return label
    }()
    
    var defaultPriceLabel: UILabel = {
        var label = UILabel()
        label.text = "none"
        label.textAlignment = .right
        label.textColor = .secondaryLabel
        return label
    }()
    
    var currentPriceLabel: UILabel = {
        var label = UILabel()
        label.textColor = .label
        label.textAlignment = .right
        label.text = "none"
        return label
    }()
    
    var button: UIButton = {
        var button = UIButton()
        button.setTitle("Go to the store", for: .normal)
        button.setTitle("Go to the store", for: .highlighted)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 6
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        
        addSubview(scrollView)
        scrollView.addSubview(largeLabel)
        scrollView.addSubview(imageView)
        
        scrollView.addSubview(shopNameLabel)
        scrollView.addSubview(nameLabel)
        scrollView.addSubview(defaultPriceLabel)
        scrollView.addSubview(currentPriceLabel)
        
        scrollView.addSubview(shop)
        scrollView.addSubview(name)
        scrollView.addSubview(defaultPrice)
        scrollView.addSubview(currentPrice)
        
        addSubview(button)
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        largeLabel.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.top).offset(16)
            make.centerX.equalTo(scrollView.snp.centerX)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(largeLabel.snp.bottom).offset(8)
            make.centerX.equalTo(scrollView.snp.centerX)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(scrollView.snp.width).multipliedBy(1.2)
        }
        
        name.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.leading.equalTo(largeLabel.snp.leading)
            make.trailing.equalTo(largeLabel.snp.centerX)
        }
        shop.snp.makeConstraints { make in
            make.top.equalTo(name.snp.bottom).offset(16)
            make.leading.equalTo(largeLabel.snp.leading)
            make.trailing.equalTo(largeLabel.snp.centerX)
        }
        defaultPrice.snp.makeConstraints { make in
            make.top.equalTo(shop.snp.bottom).offset(16)
            make.leading.equalTo(largeLabel.snp.leading)
            make.trailing.equalTo(largeLabel.snp.centerX)
        }
        currentPrice.snp.makeConstraints { make in
            make.top.equalTo(defaultPrice.snp.bottom).offset(16)
            make.leading.equalTo(largeLabel.snp.leading)
            make.trailing.equalTo(largeLabel.snp.centerX)
            make.bottom.equalTo(scrollView.snp.bottom).offset(-64).priority(.high)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.leading.equalTo(largeLabel.snp.centerX)
            make.trailing.equalTo(largeLabel.snp.trailing)
        }
        shopNameLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(16)
            make.leading.equalTo(largeLabel.snp.centerX)
            make.trailing.equalTo(largeLabel.snp.trailing)
        }
        defaultPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(shopNameLabel.snp.bottom).offset(16)
            make.leading.equalTo(largeLabel.snp.centerX)
            make.trailing.equalTo(largeLabel.snp.trailing)
        }
        currentPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(defaultPriceLabel.snp.bottom).offset(16)
            make.leading.equalTo(largeLabel.snp.centerX)
            make.trailing.equalTo(largeLabel.snp.trailing)
            make.bottom.equalTo(scrollView.snp.bottom).offset(-64).priority(.high)
        }
        button.snp.makeConstraints { make in
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).inset(16)
            make.leading.equalTo(largeLabel.snp.leading)
            make.trailing.equalTo(largeLabel.snp.trailing)
        }
    }
    
    @objc func goToShopSite() {
        guard let url = item?.url else { return }
        delegate?.goToShopSite(url: url)
    }
    
    func configureModel(model: Item) {
        self.item = model
        currentPriceLabel.text = model.newPrice
        defaultPriceLabel.text = model.oldPrice
        nameLabel.text = model.clothTitle
        largeLabel.text = model.clothTitle
        imageView.image = model.clothImage
        button.addTarget(self, action: #selector(goToShopSite), for: .touchUpInside)
    }
}
