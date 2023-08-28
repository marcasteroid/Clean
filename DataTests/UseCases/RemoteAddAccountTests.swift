//
//  RemoteAddAccountTests.swift
//  RemoteAddAccountTests
//
//  Created by Marco Margarucci on 27/08/23.
//

import XCTest
import Domain
import Data

final class RemoteAddAccountTests: XCTestCase {
    func test_add_should_call_httpClient_with_correct_url() {
        let url = URL(string: "http://url.com")!
        let (sut, httpClientSpy) = makeSut(url: url)
        sut.add(addAccountModel: makeAddAccountModel()) { _ in }
        XCTAssertEqual(httpClientSpy.urls, [url])
    }
    
    func test_add_should_call_httpClient_with_correct_data() {
        let (sut, httpClientSpy) = makeSut()
        let addAccountModel = makeAddAccountModel()
        sut.add(addAccountModel: addAccountModel) { _ in }
        XCTAssertEqual(httpClientSpy.data, addAccountModel.toData())
    }
    
    func test_add_should_complete_with_error_if_client_completes_with_error() {
        let (sut, httpClientSpy) = makeSut()
        let expectation = expectation(description: "waiting")
        sut.add(addAccountModel: makeAddAccountModel()) { result in
            switch result {
                case .failure(let error):
                    XCTAssertEqual(error, .unexpected)
                case .success:
                    XCTFail("Expected error, received \(result) instead")
            }
            expectation.fulfill()
        }
        httpClientSpy.completeWithError(.noConnectivity)
        wait(for: [expectation], timeout: 1)
    }
    
    func test_add_should_complete_with_account_if_client_completes_with_data() {
        let (sut, httpClientSpy) = makeSut()
        let expectation = expectation(description: "waiting")
        let expectedAccount = makeAccountModel()
        sut.add(addAccountModel: makeAddAccountModel()) { result in
            switch result {
                case .failure:
                    XCTFail("Expected success, received \(result) instead")
                case .success(let receivedAccount):
                    XCTAssertEqual(receivedAccount, expectedAccount)
            }
            expectation.fulfill()
        }
        httpClientSpy.completeWithData(expectedAccount.toData()!)
        wait(for: [expectation], timeout: 1)
    }
}

extension RemoteAddAccountTests {
    func makeAddAccountModel() -> AddAccountModel {
        return AddAccountModel(name: "name", email: "email", password: "password", passwordConfirmation: "password")
    }
    
    func makeAccountModel() -> AccountModel {
        return AccountModel(id: "id", name: "name", email: "email", password: "password")
    }
    
    func makeSut(url: URL = URL(string: "http://url.com")!) -> (sut: RemoteAddAccount, httpClientSpy: HttpClientSpy) {
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteAddAccount(url: url, httpClient: httpClientSpy)
        return (sut, httpClientSpy)
    }
    
    class HttpClientSpy: HttpPostClient {
        var urls = [URL]()
        var data: Data?
        var completion: ((Result<Data, HttpError>) -> Void)?
        
        func post(to url: URL, with data: Data?, completion: @escaping (Result<Data, HttpError>) -> Void) {
            self.urls.append(url)
            self.data = data
            self.completion = completion
        }
        
        func completeWithError(_ error: HttpError) {
            completion?(.failure(error))
        }
        
        func completeWithData(_ data: Data) {
            completion?(.success(data))
        }
    }
}
