//
//  AddAccountUseCasesIntegrationTests.swift
//  AddAccountUseCasesIntegrationTests
//
//  Created by Marco Margarucci on 24/10/23.
//

import XCTest
import Data
import Infra
import Domain

final class AddAccountUseCasesIntegrationTests: XCTestCase {
    
    func test_add_account() {
        let alamofireAdapter = AlamofireAdapter()
        let url = URL(string: "https://65377345bb226bb85dd34005.mockapi.io/addAccount")!
        let sut = RemoteAddAccount(url: url, httpClient: alamofireAdapter)
        let addAccountModel = AddAccountModel(name: "test", email: "test@test.com", password: "12345678", passwordConfirmation: "12345678")
        let exp = expectation(description: "waiting")
        sut.add(addAccountModel: addAccountModel) { result in
            switch result {
            case .failure: XCTFail("Expected success got \(result) instead")
            case .success(let account):
                XCTAssertNotNil(account.id)
                XCTAssertEqual(account.name, addAccountModel.name)
                XCTAssertEqual(account.email, addAccountModel.email)
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 5)
    }
    
}
