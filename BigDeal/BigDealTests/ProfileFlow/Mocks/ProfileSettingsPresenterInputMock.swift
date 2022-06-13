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
    
    var obtainTextFieldDataStubbed: String = ""
    
    func obtainTextFieldData() -> String {
        return obtainTextFieldDataStubbed
    }
    
    func obtainTextFieldDataLenght() -> Int {
        let textFieldData = "Carti"
        return textFieldData.count
    }
}
