//
//  AlamofireAdapterTests.swift.swift
//  AlamofireAdapterTests.swift
//
//  Created by Marco Margarucci on 31/08/23.
//

import XCTest
import Alamofire

class AlamofireAdapter {
    
    private let session: Session
    
    init(session: Session = .default) {
        self.session = session
    }
    
    func post(to url: URL, with data: Data?) {
        let json = try? JSONSerialization.jsonObject(with: data!, options: .fragmentsAllowed) as? [String: Any]
        session.request(url, method: .post,
                        parameters: json,
                        encoding: JSONEncoding.default).resume()
    }
}

final class InfraTests: XCTestCase {
    
    func test_post_should_make_request_with_valid_url_and_method() {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [URLProtocolStub.self]
        let session = Session(configuration: configuration)
        let sut = AlamofireAdapter(session: session)
        let url = makeURL()
        sut.post(to: url, with: makeValidData())
        let expectation = expectation(description: "waiting")
        URLProtocolStub.observeRequest { request in
            XCTAssertEqual(url, request.url)
            XCTAssertEqual("POST", request.httpMethod)
            XCTAssertNotNil(request.httpBodyStream)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
}


class URLProtocolStub: URLProtocol {
    static var emit: ((URLRequest) -> Void)?
    
    static func observeRequest(completion: @escaping (URLRequest) -> Void) {
        URLProtocolStub.emit = completion
    }
    
    override open func stopLoading() {}
    
    override open class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override open class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
 
    override open func startLoading() {
        URLProtocolStub.emit?(request)
    }
}
