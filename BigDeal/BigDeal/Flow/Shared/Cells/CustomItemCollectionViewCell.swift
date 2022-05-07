import UIKit

class CustomItemCollectionViewCell: UICollectionViewCell {
    // MARK: - Static properties
    
    static let customItemCollectionViewCellReuseId: String = "customItemCollectionViewCell"
    
    // MARK: - Properties
    
    var data: Item? {
        didSet {
            guard let data = data else {
                return
            }
            itemImageView.image = data.clothImage
            itemShopTitleLabel.text = data.shopTitle
            itemTitleLabel.text = data.clothTitle
            itemAvailableSizesLabel.text = data.sizes.joined(separator: ",")
            let attributeString = NSMutableAttributedString(string: "\(data.oldPrice)")
                attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: attributeString.length))
            itemOldPriceLabel.attributedText = attributeString
            itemNewPriceLabel.text = data.newPrice
        }
    }
    
    private lazy var itemShopTitleLabel: UILabel = {
        let label = UILabel()
        label.text = nil
        label.textColor = .systemGray
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    private lazy var itemTitleLabel: UILabel = {
        let label = UILabel()
        label.text = nil
        label.textColor = .label
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var itemAvailableSizesLabel: UILabel = {
        let label = UILabel()
        label.text = nil
        label.textColor = .systemGray
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    private lazy var itemOldPriceLabel: UILabel = {
        let label = UILabel()
        label.text = nil
        label.textColor = .systemGray
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    private lazy var itemNewPriceLabel: UILabel = {
        let label = UILabel()
        label.text = nil
        label.textColor = .systemBlue
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    private lazy var itemImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.image = UIImage(named: "radio-off")
        image.layer.cornerRadius = 12
        return image
    }()
    
    // MARK: - Overrided
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUpConstraintsForViews()
    }
    
    // Initializers
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = .systemBackground
        setUpSelfContentView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private funcs
    
    private func setUpSelfContentView() {
        contentView.addSubview(itemImageView)
        contentView.addSubview(itemShopTitleLabel)
        contentView.addSubview(itemTitleLabel)
        contentView.addSubview(itemOldPriceLabel)
        contentView.addSubview(itemNewPriceLabel)
    }
    
    private func setUpConstraintsForViews() {
        itemImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
            make.left.equalToSuperview()
        }
        itemShopTitleLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(25)
            make.left.equalToSuperview()
        }
        itemTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(itemShopTitleLabel).inset(17)
            make.left.equalToSuperview()
        }
        itemOldPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(itemTitleLabel).inset(22)
            make.left.equalToSuperview()
        }
        itemNewPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(itemOldPriceLabel).inset(18)
            make.left.equalToSuperview()
        }
    }
}
