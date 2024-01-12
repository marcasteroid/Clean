//
//  SignUpViewControllerTests.swift
//  SignUpViewControllerTests
//
//  Created by Marco Margarucci on 12/01/24.
//

import XCTest
@testable import UI

final class SignUpViewControllerTests: XCTestCase {

    func test_loading_is_hidden_on_start() throws {
        let sut = SignUpViewController()
        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.activityIndicator.isAnimating, false)
    }
}
