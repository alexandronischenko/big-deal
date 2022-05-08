import XCTest
@testable import BigDeal

class ProfileSettingsValidatorUnitTests: XCTestCase {
    // MARK: - Properties
    private var profileSettingsViewController: ProfileSettingsPresenterInputMock!
    private var validationService: ValidationServiceProtocol!
    
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
    
    func testValidationResultFalseToShortName() {
        // Arrange
        profileSettingsViewController.obtainTextFieldDataStubbed = "Ян"
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
    
    func testNamesAreEqual() {
        // Arrange
        guard let profileSettingsViewController = profileSettingsViewController else {
            return
        }
        // Act
        let name = profileSettingsViewController.obtainTextFieldData()
        let comparisonName = "Dmitriy"
        // Assert
        XCTAssertEqual(name, comparisonName)
    }
    
    func testNamesAreNotEqual() {
        // Arrange
        guard let profileSettingsViewController = profileSettingsViewController else {
            return
        }
        // Act
        let name = profileSettingsViewController.obtainTextFieldData()
        let comparisonName = "Dmitriy"
        // Assert
        XCTAssertNotEqual(name, comparisonName)
    }
    
    func testLenghtIsEqual() {
        // Arrange
        guard let profileSettingsViewController = profileSettingsViewController else {
            return
        }
        // Act
        let lenght = profileSettingsViewController.obtainTextFieldDataLenght()
        let comparisonData = "Pierre"
        let comparisonLenght = comparisonData.count
        
        // Assert
        XCTAssertEqual(lenght, comparisonLenght)
    }
    
    func testLenghtIsNotEqual() {
        // Arrange
        guard let profileSettingsViewController = profileSettingsViewController else {
            return
        }
        // Act
        let lenght = profileSettingsViewController.obtainTextFieldDataLenght()
        let comparisonData = "Pierre"
        let comparisonLenght = comparisonData.count
        
        // Assert
        XCTAssertNotEqual(lenght, comparisonLenght)
    }
    
    func testInpuLenghtIsBigger() {
        // Arrange
        guard let profileSettingsViewController = profileSettingsViewController else {
            return
        }
        // Act
        let lenght = profileSettingsViewController.obtainTextFieldDataLenght()
        let comparisonData = "Pierre"
        let comparisonLenght = comparisonData.count
        
        // Assert
        XCTAssertTrue(lenght > comparisonLenght)
    }
    
    func testInpuLenghtIsSmaller() {
        // Arrange
        guard let profileSettingsViewController = profileSettingsViewController else {
            return
        }
        // Act
        let lenght = profileSettingsViewController.obtainTextFieldDataLenght()
        let comparisonData = "Pierre"
        let comparisonLenght = comparisonData.count
        
        // Assert
        XCTAssertTrue(lenght < comparisonLenght)
    }
}
