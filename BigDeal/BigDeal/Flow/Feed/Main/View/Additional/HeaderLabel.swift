import UIKit

class HeaderLabel: UICollectionReusableView {
    
     var label: UILabel = {
         let label = UILabel()
         label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
         label.sizeToFit()
         return label
     }()

     override init(frame: CGRect) {
         super.init(frame: frame)

         addSubview(label)

         label.snp.makeConstraints { make in
             make.centerX.equalToSuperview()
         }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
