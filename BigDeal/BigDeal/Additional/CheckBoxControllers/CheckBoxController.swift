import Foundation
import UIKit

class CheckBoxController: NSObject {
    // MARK: - Properties
    
    var selectedButtons: [UIButton] = []
    var buttonsArray: [UIButton] = [] {
        didSet {
            for button in buttonsArray {
                button.setImage(UIImage(systemName: "checkmark.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .regular, scale: .default)), for: .selected)
                button.setImage(UIImage(systemName: "circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .regular, scale: .default)), for: .normal)
            }
        }
    }
    var defaultButtonForBrandsCategory = UIButton() {
        didSet {
            buttonsArrayUpdated(buttonSelected: self.defaultButtonForBrandsCategory)
        }
    }
    var defaultButtonForShopsCategory = UIButton() {
        didSet {
            buttonsArrayUpdated(buttonSelected: self.defaultButtonForShopsCategory)
        }
    }
    
    // MARK: - Private funcs
    
    private func buttonsArrayUpdated(buttonSelected: UIButton) {
        for button in buttonsArray {
            if (button == buttonSelected) && !button.isSelected {
                selectedButtons.append(button)
                button.isSelected = true
            } else if button == buttonSelected && button.isSelected {
                selectedButtons = selectedButtons.filter {
                    $0 !== button
                }
                button.isSelected = false
            }
        }
    }
    
    // MARK: - Other funcs
    
    func addButtonToCheckBoxController(_ button: UIButton) {
        button.addTarget(self, action: #selector(buttonDidPressed), for: .touchUpInside)
        buttonsArray.append(button)
    }
    
    // MARK: - OBJC funcs
    
    @objc private func buttonDidPressed(_ sender: UIButton) {
        buttonsArrayUpdated(buttonSelected: sender)
    }
}
