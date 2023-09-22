//
//  TestFactories.swift
//  DataTests
//
//  Created by Marco Margarucci on 31/08/23.
//

import Foundation

func makeURL() -> URL {
    return URL(string: "http://url.com")!
}

func makeInvalidData() -> Data {
    return Data("invalidData".utf8)
}

func makeEmptyData() -> Data {
    return Data()
}

func makeValidData() -> Data {
    return Data("{\"name\":\"anyName\"}".utf8)
}

func makeError() -> Error {
    return NSError(domain: "error", code: 0)
}

func makeHTTPResponse(statusCode: Int = 200) -> HTTPURLResponse {
    return HTTPURLResponse(url: makeURL(), statusCode: statusCode, httpVersion: nil, headerFields: nil)!
}
