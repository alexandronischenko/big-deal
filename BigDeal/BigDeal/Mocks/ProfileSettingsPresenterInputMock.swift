import Foundation

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
}
