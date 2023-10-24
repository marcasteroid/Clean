//
//  AlamofireAdapterTests.swift.swift
//  AlamofireAdapterTests.swift
//
//  Created by Marco Margarucci on 31/08/23.
//

import XCTest
import Alamofire
import Data
import Infra

final class AlamofireAdapterTests: XCTestCase {
    
    func test_post_should_make_request_with_valid_url_and_method() {
        let url = makeURL()
        testRequestFor(url: url, data: makeValidData()) { request in
            XCTAssertEqual(url, request.url)
            XCTAssertEqual("POST", request.httpMethod)
            XCTAssertNotNil(request.httpBodyStream)
        }
    }
    
    func test_post_should_make_request_with_no_data() {
        testRequestFor(data: nil) { request in
            XCTAssertNil(request.httpBodyStream)
        }
    }
    
    func test_post_should_complete_with_error_when_request_completes_with_error() {
        expectResult(.failure(.noConnectivity), when: (data: nil, response: nil, error: makeError()))
    }
    
    func test_post_should_complete_with_error_on_all_invalid_cases() {
        expectResult(.failure(.noConnectivity), when: (data: makeValidData(), response: makeHTTPResponse(), error: makeError()))
        expectResult(.failure(.noConnectivity), when: (data: makeValidData(), response: nil, error: makeError()))
        expectResult(.failure(.noConnectivity), when: (data: makeValidData(), response: nil, error: nil))
        expectResult(.failure(.noConnectivity), when: (data: nil, response: makeHTTPResponse(), error: makeError()))
        expectResult(.failure(.noConnectivity), when: (data: nil, response: makeHTTPResponse(), error: nil))
        expectResult(.failure(.noConnectivity), when: (data: nil, response: nil, error: nil))
    }
    
    func test_post_should_complete_with_no_data_when_request_completes_with_200() {
        expectResult(.success(makeValidData()), when: (data: makeValidData(), response: makeHTTPResponse(), error: nil))

    }
    
    func test_post_should_complete_with_data_when_request_completes_with_204() {
        expectResult(.success(nil), when: (data: nil, response: makeHTTPResponse(statusCode: 204), error: nil))
        expectResult(.success(nil), when: (data: makeEmptyData(), response: makeHTTPResponse(statusCode: 204), error: nil))
        expectResult(.success(nil), when: (data: makeValidData(), response: makeHTTPResponse(statusCode: 204), error: nil))
    }
    
    func test_post_should_complete_with_error_when_request_completes_with_non_200() {
        expectResult(.failure(.badRequest), when: (data: makeValidData(), response: makeHTTPResponse(statusCode: 400), error: nil))
        expectResult(.failure(.serverError), when: (data: makeValidData(), response: makeHTTPResponse(statusCode: 500), error: nil))
        expectResult(.failure(.unauthorized), when: (data: makeValidData(), response: makeHTTPResponse(statusCode: 401), error: nil))
        expectResult(.failure(.forbidden), when: (data: makeValidData(), response: makeHTTPResponse(statusCode: 403), error: nil))
    }
}

// MARK: - Extensions

extension AlamofireAdapterTests {
    
    func makeSut(file: StaticString = #file, line: UInt = #line) -> AlamofireAdapter {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [URLProtocolStub.self]
        let session = Session(configuration: configuration)
        let sut = AlamofireAdapter(session: session)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
    
    func testRequestFor(url: URL = makeURL(), data: Data?, action: @escaping (URLRequest) -> Void) {
        let sut = makeSut()
        let expectation = XCTestExpectation(description: "waiting")
        var request: URLRequest?
        sut.post(to: url, with: data) { _ in expectation.fulfill() }
        URLProtocolStub.observeRequest { request = $0 }
        wait(for: [expectation], timeout: 1)
        action(request!)
    }
    
    func expectResult(_ expectedResult: Result<Data?, HttpError>, when stub: (data: Data?, response: HTTPURLResponse?, error: Error?), file: StaticString = #file, line: UInt = #line) {
        let sut = makeSut()
        URLProtocolStub.simulate(data: stub.data, reponse: stub.response, error: stub.error)
        let expectation = XCTestExpectation(description: "waitingExpectResult")
        sut.post(to: makeURL(), with: makeValidData()) { receivedResult in
            switch (expectedResult, receivedResult) {
            case (.success(let expectedData), .success(let receivedData)):
                XCTAssertEqual(expectedData, receivedData, file: file, line: line)
            case (.failure(let expectedError), .failure(let receivedError)):
                XCTAssertEqual(expectedError, receivedError, file: file, line: line)
            default:
                XCTFail("Expected \(expectedResult), received \(expectedResult) instead")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
}
