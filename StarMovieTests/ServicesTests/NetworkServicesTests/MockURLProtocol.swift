//
//  MockURLProtocol.swift
//  StarMovie
//
//  Created by petar on 30.12.2024.
//

import Foundation

class MockURLProtocol: URLProtocol {
    static var mockResponses: [URL: (Data?, URLResponse?, Error?)] = [:]
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        guard let url = request.url else {
            client?.urlProtocol(self, didFailWithError: NSError(domain: "Mock", code: 0, userInfo: nil))
            return
        }

        if let mockResponse = MockURLProtocol.mockResponses[url] {
            if let data = mockResponse.0 {
                print("Mocking data for URL: \(url)")
                client?.urlProtocol(self, didLoad: data)
            }
            if let response = mockResponse.1 {
                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            }
            if let error = mockResponse.2 {
                client?.urlProtocol(self, didFailWithError: error)
            }
        }
        client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() {}
}

