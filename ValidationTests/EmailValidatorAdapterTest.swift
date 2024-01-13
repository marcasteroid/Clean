//
//  EmailValidatorAdapterTest.swift.swift
//  EmailValidatorAdapterTest.swift
//
//  Created by Marco Margarucci on 13/01/24.
//

import XCTest
import Presentation
@testable import Validation

final class EmailValidatorAdapterTests: XCTestCase {

    func test_invalid_emails()  {
        let sut = makeSut()
        XCTAssertFalse(sut.isValid(email: "test"))
        XCTAssertFalse(sut.isValid(email: "test@"))
        XCTAssertFalse(sut.isValid(email: "test@test"))
        XCTAssertFalse(sut.isValid(email: "@test.com"))
    }
    
    func test_valid_emails()  {
        let sut = EmailValidatorAdapter()
        XCTAssertTrue(sut.isValid(email: "test@test.com"))
    }
}

extension EmailValidatorAdapterTests {
    func makeSut() -> EmailValidatorAdapter {
        return EmailValidatorAdapter()
    }
}
