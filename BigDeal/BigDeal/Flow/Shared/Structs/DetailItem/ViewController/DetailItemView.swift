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
        return scroll
    }()
    
    var shop: UILabel = {
        var label = UILabel()
        label.text = "Shop:"
        label.textColor = .tertiaryLabel
        return label
    }()

    var sizes: UILabel = {
        var label = UILabel()
        label.text = "Sizes:"
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
        // MARK: - FIX IT
        var image = UIImage(systemName: "bag")
        var imageView = UIImageView(image: image)
        imageView.tintColor = .label
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var shopNameLabel: UILabel = {
        var label = UILabel()
        // MARK: - FIX IT
        label.text = "Adidas"
        label.textColor = .label
        label.textAlignment = .right
        return label
    }()
    
    var sizesLabel: UILabel = {
        var label = UILabel()
        // MARK: - FIX IT
        label.textColor = .label
        label.textAlignment = .right
        label.text = "41 42 43"
        return label
    }()
    
    var defaultPriceLabel: UILabel = {
        var label = UILabel()
        // MARK: - FIX IT
        label.text = "2000$"
        label.textAlignment = .right
        label.textColor = .secondaryLabel
        return label
    }()
    
    var currentPriceLabel: UILabel = {
        var label = UILabel()
        label.textColor = .label
        label.textAlignment = .right
        // MARK: - FIX IT
        label.text = "1000$"
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
        
        backgroundColor = .systemBackground

        addSubview(scrollView)
        scrollView.addSubview(imageView)
        
        scrollView.addSubview(shopNameLabel)
        scrollView.addSubview(sizesLabel)
        scrollView.addSubview(defaultPriceLabel)
        scrollView.addSubview(currentPriceLabel)
        
        scrollView.addSubview(shop)
        scrollView.addSubview(sizes)
        scrollView.addSubview(defaultPrice)
        scrollView.addSubview(currentPrice)
        
        scrollView.addSubview(button)
        
        setConstraints()
        // MARK: - FIX IT
//        title = "krossovrki"
//        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        imageView.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.top).offset(16)
            make.centerX.equalTo(scrollView.snp.centerX)
            make.height.width.equalTo(scrollView.snp.width).multipliedBy(0.9)
        }
        
        shop.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(16)
            make.leading.equalTo(imageView.snp.leading)
            make.trailing.equalTo(imageView.snp.centerX)
        }
        sizes.snp.makeConstraints { make in
            make.top.equalTo(shop.snp.bottom).offset(16)
            make.leading.equalTo(imageView.snp.leading)
            make.trailing.equalTo(imageView.snp.centerX)
        }
        defaultPrice.snp.makeConstraints { make in
            make.top.equalTo(sizes.snp.bottom).offset(16)
            make.leading.equalTo(imageView.snp.leading)
            make.trailing.equalTo(imageView.snp.centerX)
        }
        currentPrice.snp.makeConstraints { make in
            make.top.equalTo(defaultPrice.snp.bottom).offset(16)
            make.leading.equalTo(imageView.snp.leading)
            make.trailing.equalTo(imageView.snp.centerX)
        }
        
        shopNameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(16)
            make.leading.equalTo(imageView.snp.centerX)
            make.trailing.equalTo(imageView.snp.trailing)
        }
        sizesLabel.snp.makeConstraints { make in
            make.top.equalTo(shopNameLabel.snp.bottom).offset(16)
            make.leading.equalTo(imageView.snp.centerX)
            make.trailing.equalTo(imageView.snp.trailing)
        }
        defaultPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(sizesLabel.snp.bottom).offset(16)
            make.leading.equalTo(imageView.snp.centerX)
            make.trailing.equalTo(imageView.snp.trailing)
        }
        currentPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(defaultPriceLabel.snp.bottom).offset(16)
            make.leading.equalTo(imageView.snp.centerX)
            make.trailing.equalTo(imageView.snp.trailing)
        }
        button.snp.makeConstraints { make in
            make.top.equalTo(currentPrice.snp.bottom).offset(16)
            make.bottom.equalTo(scrollView.snp.bottom).offset(-16)
            make.leading.equalTo(imageView.snp.leading)
            make.trailing.equalTo(imageView.snp.trailing)
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
        imageView.image = model.clothImage
        button.addTarget(self, action: #selector(goToShopSite), for: .touchUpInside)
    }
}
