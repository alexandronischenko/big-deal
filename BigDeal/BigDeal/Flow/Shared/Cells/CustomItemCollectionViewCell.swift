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
            itemTitleLabel.text = data.clothTitle
            let attributeString = NSMutableAttributedString(string: "\(data.oldPrice)")
                attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: attributeString.length))
            itemOldPriceLabel.attributedText = attributeString
            itemNewPriceLabel.text = data.newPrice
        }
    }
    // MARK: - UI
    
    private lazy var itemImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.image = UIImage(named: "radio-off")
        image.layer.cornerRadius = 12
        return image
    }()
    
    private lazy var itemTitleLabel: UILabel = {
        let label = UILabel()
        label.text = nil
        label.textColor = .label
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    private lazy var itemOldPriceLabel: UILabel = {
        let label = UILabel()
        label.text = nil
        label.textColor = .systemGray
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    private lazy var itemNewPriceLabel: UILabel = {
        let label = UILabel()
        label.text = nil
        label.textColor = .systemBlue
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    lazy var addToFavouritesButton: UIButton = {
        let button = UIButton(type: .custom)
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
        super.init(frame: .zero)
        self.backgroundColor = .systemBackground
        contentView.isUserInteractionEnabled = true
        setUpSelfContentView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Private functions
    
    private func setUpSelfContentView() {
        contentView.addSubview(itemImageView)
        contentView.addSubview(itemTitleLabel)
        contentView.addSubview(itemOldPriceLabel)
        contentView.addSubview(itemNewPriceLabel)
        contentView.addSubview(addToFavouritesButton)
    }
    
    private func setUpConstraintsForViews() {
        itemImageView.snp.makeConstraints { make in
            make.top.trailing.leading.equalToSuperview()
            make.bottom.equalToSuperview().inset(70)
        }
        itemTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(itemImageView.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview()
        }
        itemOldPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(itemTitleLabel).inset(25)
            make.leading.equalToSuperview()
        }
        itemNewPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(itemOldPriceLabel).inset(20)
            make.leading.equalToSuperview()
        }
        addToFavouritesButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.top.equalTo(itemTitleLabel).inset(32)
        }
    }
    // MARK: - OBJC functions
    
    @objc func addToFavouritesButtonDidPressed(_ sender: UIButton) {
        if !sender.isSelected {
            sender.isSelected = true
        } else if sender.isSelected {
            sender.isSelected = false
        }
    }
}
