import Foundation
import UIKit

class RadioButtonController: NSObject {
    // MARK: - Properties
    
    var selectedButtons: [UIButton] = []
    var buttonsArray: [UIButton] = [] {
        didSet {
            for button in buttonsArray {
                button.setImage(UIImage(systemName: "circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .thin, scale: .default)), for: .normal)
                button.setImage(UIImage(systemName: "circle.inset.filled", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .regular, scale: .default)), for: .selected)
            }
        }
    }
    var defaultButtonForSexCategory = UIButton() {
        didSet {
            buttonArrayUpdated(buttonSelected: self.defaultButtonForSexCategory)
        }
    }
    var defaultButtonForSortByCategory = UIButton() {
        didSet {
            buttonArrayUpdated(buttonSelected: self.defaultButtonForSortByCategory)
        }
    }
    var defaultButtonForPriceRangeCategory = UIButton() {
        didSet {
            buttonArrayUpdated(buttonSelected: self.defaultButtonForPriceRangeCategory)
        }
    }
    
    // MARK: - Private funcs
    
    private func buttonArrayUpdated(buttonSelected: UIButton) {
        for button in buttonsArray {
            if button == buttonSelected {
                selectedButtons.append(button)
                button.isSelected = true
            } else {
                button.isSelected = false
            }
        }
    }
    
    // MARK: - Other funcs
    
    func addButtonForRadioController(_ button: UIButton) {
        button.addTarget(self, action: #selector(categoryButtonDidPressed), for: .touchUpInside)
        buttonsArray.append(button)
    }
    
    // MARK: - OBJC funcs
    
    @objc private func categoryButtonDidPressed(_ sender: UIButton) {
        buttonArrayUpdated(buttonSelected: sender)
    }
}
