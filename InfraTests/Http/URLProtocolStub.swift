//
//  URLProtocolStub.swift
//  InfraTests
//
//  Created by Marco Margarucci on 24/10/23.
//

import Foundation

class URLProtocolStub: URLProtocol {
    static var emit: ((URLRequest) -> Void)?
    static var data: Data?
    static var response: HTTPURLResponse?
    static var error: Error?
    
    static func simulate(data: Data?, reponse: HTTPURLResponse?, error: Error?) {
        URLProtocolStub.data = data
        URLProtocolStub.response = reponse
        URLProtocolStub.error = error
    }
    
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
        
        if let data = URLProtocolStub.data {
            client?.urlProtocol(self, didLoad: data)
        }
        
        if let response = URLProtocolStub.response {
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        }
        
        if let error = URLProtocolStub.error {
            client?.urlProtocol(self, didFailWithError: error)
        }
        
        client?.urlProtocolDidFinishLoading(self)
    }
}
