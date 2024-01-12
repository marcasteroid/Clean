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
        let sut = SignUpViewController()
        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.activityIndicator.isAnimating, false)
    }
    
    func test_sut_implements_loadingView() {
        let sut = SignUpViewController()
        sut.loadViewIfNeeded()
        XCTAssertNotNil(sut as LoadingView)
    }
}
