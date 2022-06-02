import UIKit
import SnapKit

protocol AuthenticationGreetingViewProtocol: AnyObject {
    func didPressedLetsGetStarted()
}

class AuthenticationGreetingView: UIView {
    // MARK: - Properties
    
    weak var delegate: AuthenticationGreetingViewProtocol?
    
    lazy var scrollView: UIScrollView = {
        var scroll = UIScrollView()
        return scroll
    }()
    
    lazy var emojiLabel: UILabel = {
        var label = UILabel()
        label.text = "✌️"
        label.font = label.font.withSize(30)
        label.baselineAdjustment = .alignCenters
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    lazy var helloLabel: UILabel = {
        var label = UILabel()
        label.text = "Hello!"
        label.font = .systemFont(ofSize: 26, weight: .medium)
        label.baselineAdjustment = .alignCenters
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    lazy var label: UILabel = {
        var label = UILabel()
        label.font = label.font.withSize(18)
        label.textColor = .label
        label.text = "Signing into the app will help you receive exclusive discounts for your interests and follow price changes"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    lazy var button: UIButton = {
        var button = UIButton(type: .system)
        button.setTitle("Get to work", for: .normal)
        button.setTitle("Get to work", for: .highlighted)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 6
        button.addTarget(self, action: #selector(didPressedLetsGetStarted), for: .touchUpInside)
        return button
    }()
    // MARK: - View life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        
        addSubview(scrollView)
        scrollView.addSubview(button)
        scrollView.addSubview(emojiLabel)
        scrollView.addSubview(helloLabel)
        scrollView.addSubview(label)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Private functions
    
    private func setConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        emojiLabel.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.top).offset(128)
            make.centerX.equalTo(scrollView.snp.centerX)
        }
        helloLabel.snp.makeConstraints { make in
            make.top.equalTo(emojiLabel.snp.bottom)
            make.centerX.equalTo(emojiLabel.snp.centerX)
        }
        label.snp.makeConstraints { make in
            make.top.equalTo(helloLabel.snp.top).offset(36)
            make.centerX.equalTo(scrollView.snp.centerX)
            make.width.equalTo(scrollView.snp.width).multipliedBy(0.7)
        }
        button.snp.makeConstraints { make in
            make.bottom.equalTo(scrollView.safeAreaLayoutGuide.snp.bottom).inset(16)
            make.centerX.equalTo(scrollView.snp.centerX)
            make.width.equalTo(scrollView.snp.width).multipliedBy(0.9)
        }
    }
    
    // MARK: - Obj-c functions
    
    @objc func didPressedLetsGetStarted() {
        delegate?.didPressedLetsGetStarted()
    }
}
