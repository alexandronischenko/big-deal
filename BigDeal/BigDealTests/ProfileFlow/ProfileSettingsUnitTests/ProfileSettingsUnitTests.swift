import XCTest
@testable import BigDeal

class ProfileSettingsUnitTests: XCTestCase {
    // MARK: - Properties
    
    private var profileSettingsViewController: ProfileSettingsPresenterInputProtocol?
    private var validationService: ValidationServiceProtocol?
    
    // MARK: - Overrided functions

    override func setUpWithError() throws {
        profileSettingsViewController = ProfileSettingsPresenterInputMock()
        validationService = ValidationService()
    }

    override func tearDownWithError() throws {
        profileSettingsViewController = nil
        validationService = nil
    }
    
    // MARK: - Test functions
    
    func testNameIsShort() {
        // Arrange
        guard let profileSettingsViewController = profileSettingsViewController else {
            return
        }
        let name = profileSettingsViewController.obtainTextFieldData()
        // Act
        guard let isValidName = validationService?.isValidName(name) else { return }
        let isValid = isValidName
        // Assert
        XCTAssertFalse(isValid)
    }
    
    func testNameIsNotShort() {
        // Arrange
        guard let profileSettingsViewController = profileSettingsViewController else {
            return
        }
        let name = profileSettingsViewController.obtainTextFieldData()
        // Act
        guard let isValidName = validationService?.isValidName(name) else { return }
        let isValid = isValidName
        // Assert
        XCTAssertTrue(isValid)
    }
    
    func testNameIsLong() {
        // Arrange
        guard let profileSettingsViewController = profileSettingsViewController else {
            return
        }
        let name = profileSettingsViewController.obtainTextFieldData()
        // Act
        guard let isValidName = validationService?.isValidName(name) else { return }
        let isValid = isValidName
        // Assert
        XCTAssertFalse(isValid)
    }
    
    func testNameIsNotLong() {
        // Arrange
        guard let profileSettingsViewController = profileSettingsViewController else {
            return
        }
        let name = profileSettingsViewController.obtainTextFieldData()
        // Act
        guard let isValidName = validationService?.isValidName(name) else { return }
        let isValid = isValidName
        // Assert
        XCTAssertTrue(isValid)
    }
    
    func testNameIsNotNil() {
        // Arrange
        guard let profileSettingsViewController = profileSettingsViewController else {
            return
        }
        // Act
        let name = profileSettingsViewController.obtainTextFieldData()
        // Assert
        XCTAssertNotNil(name)
    }
    
    func testNameIsNil() {
        // Arrange
        guard let profileSettingsViewController = profileSettingsViewController else {
            return
        }
        // Act
        let name = profileSettingsViewController.obtainTextFieldData()
        // Assert
        XCTAssertNil(name)
    }
}
