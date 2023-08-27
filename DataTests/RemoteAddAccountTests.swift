//
//  RemoteAddAccountTests.swift
//  RemoteAddAccountTests
//
//  Created by Marco Margarucci on 27/08/23.
//

import XCTest

class RemoteAddAccount {
    private var url: URL
    private var httpClient: HttpClient
    
    init(url: URL, httpClient: HttpClient) {
        self.url = url
        self.httpClient = httpClient
    }
    
    func add() {
        httpClient.post(url: url)
    }
}

protocol HttpClient {
    func post(url: URL)
}

final class RemoteAddAccountTests: XCTestCase {
    func test_() {
        let url = URL(string: "http://url.com")!
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteAddAccount(url: url, httpClient: httpClientSpy)
        sut.add()
        XCTAssertEqual(httpClientSpy.url, url)
    }
    
    class HttpClientSpy: HttpClient {
        var url: URL?
        
        func post(url: URL) {
            self.url = url
        }
    }
}
