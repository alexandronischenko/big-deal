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
    var defaultButton = UIButton() {
        didSet {
            buttonArrayUpdated(buttonSelected: self.defaultButton)
        }
    }
    // MARK: - Private funtions
    
    private func buttonArrayUpdated(buttonSelected: UIButton) {
        for button in buttonsArray {
            if button == buttonSelected {
                selectedButtons.append(button)
                button.isSelected = true
            } else {
                selectedButtons = selectedButtons.filter {
                    $0 !== button
                }
                button.isSelected = false
            }
        }
    }
    // MARK: - Other functions
    
    func addButtonForRadioController(_ button: UIButton) {
        button.addTarget(self, action: #selector(categoryButtonDidPressed), for: .touchUpInside)
        if !buttonsArray.contains(button) {
            buttonsArray.append(button)
        }
    }
    // MARK: - OBJC functions
    
    @objc private func categoryButtonDidPressed(_ sender: UIButton) {
        buttonArrayUpdated(buttonSelected: sender)
    }
}
