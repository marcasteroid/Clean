//
//  SignUpViewControllerTests.swift
//  SignUpViewControllerTests
//
//  Created by Marco Margarucci on 12/01/24.
//

import XCTest
import Presentation
@testable import UI

final class SignUpViewControllerTests: XCTestCase {

    func test_loading_is_hidden_on_start() throws {
        XCTAssertEqual(makeSut().activityIndicator.isAnimating, false)
    }
    
    func test_sut_implements_loadingView() {
        XCTAssertNotNil(makeSut() as LoadingView)
    }
    
    func test_sut_implements_alertView() {
        XCTAssertNotNil(makeSut() as AlertView)
    }
}

extension SignUpViewControllerTests {
    func makeSut() -> SignUpViewController {
        let sut = SignUpViewController()
        sut.loadViewIfNeeded()
        return sut
    }
}
