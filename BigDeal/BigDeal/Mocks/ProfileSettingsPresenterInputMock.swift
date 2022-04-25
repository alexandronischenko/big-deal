import Foundation
import UIKit

class ProfileSettingsPresenterInputMock: ProfileSettingsPresenterInputProtocol {
    // MARK: - Properties
    
    var output: ProfileSettingsPresenterOutputProtocol?
    
    // MARK: - Initializers
    
    init() { }
    
    init(output: ProfileSettingsPresenterOutputProtocol) {
        self.output = output
    }
    
    // MARK: - Functions
    
    func obtainTextFieldData() -> String {
        let textFieldData = "Renat"
        return textFieldData
    }
    
    func obtainTextFieldDataLenght() -> Int {
        let textFieldData = "Carti"
        return textFieldData.count
    }
}
