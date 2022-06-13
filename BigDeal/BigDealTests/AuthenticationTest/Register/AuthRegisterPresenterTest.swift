//
//  AuthRegisterPresenterTest.swift
//  BigDealTests
//
//  Created by Alexandr Onischenko on 30.03.2022.
//

import XCTest
@testable import BigDeal

class AuthRegisterPresenterTest: XCTestCase {
    var view: MockAuthRegisterView?
    var presenter: AuthenticationRegisterViewPresenter?
    var coordinator: AuthenticationCoordinator?
    
    override func setUpWithError() throws {
        view = MockAuthRegisterView()
        coordinator = MockCoordinator(rootNavigationViewController: UINavigationController())
        presenter = AuthenticationRegisterViewPresenter(coordinator: coordinator ?? MockCoordinator(rootNavigationViewController: UINavigationController()))
        presenter?.view = view
    }

    override func tearDownWithError() throws {
        view = nil
        presenter = nil
        coordinator = nil
    }

    func testModuleIsNotNil() throws {
        XCTAssertNotNil(view, "view is not nil")
        XCTAssertNotNil(presenter, "presenter is not nil")
    }
    
    func testEmailIsValid() {
        // given
        let email = "simple@example.com"
        
        // when
        guard let isValid = presenter?.isValidEmail(email) else { return }
        
        // then
        XCTAssertFalse(isValid)
    }
    
    func testEmailDoesNoContainAtCharacter() {
        // given
        let email = "Abc.example.com"
        
        // when
        guard let isValid = presenter?.isValidEmail(email) else { return }
        
        // then
        XCTAssertFalse(isValid)
    }
    
    func testEmailContainsMoreThanOneAtCharacter() {
        // given
        let email = "A@b@c@example.com"
        
        // when
        guard let isValid = presenter?.isValidEmail(email) else { return }
        
        // then
        XCTAssertFalse(isValid)
    }
    
    func testNameIsTooShort() {
        // given
        let name = "a"
        
        // when
        guard let isValid = presenter?.isValidName(name) else { return }
        
        // then
        XCTAssertFalse(isValid)
    }
    
    func testPasswordDoesNotContainAtLeastOneNumber() {
        // given
        let password = "qwertyui"
        
        // when
        guard let isValid = presenter?.isValidPassword(password) else { return }
        
        // then
        XCTAssertFalse(isValid)
    }
    
    func testPasswordIsTooShort() {
        // given
        let password = "qwert"
        
        // when
        guard let isValid = presenter?.isValidPassword(password) else { return }
        
        // then
        XCTAssertFalse(isValid)
    }
    
    func testPasswordDoesNotContainAtLeastOneLetter() {
        // given
        let password = "12345678"
        
        // when
        guard let isValid = presenter?.isValidPassword(password) else { return }
        
        // then
        XCTAssertFalse(isValid)
    }
}
