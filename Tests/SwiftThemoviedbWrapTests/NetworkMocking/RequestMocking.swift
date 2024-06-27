//
//  File.swift
//  
//
//  Created by PhuongDoan on 21/6/24.
//

import XCTest

class MockingURLProtocol: URLProtocol {
    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data))?

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        guard let handler = MockingURLProtocol.requestHandler else {
            XCTFail("Received unexpected request with no handler set")
            return
        }
        do {
            let (response, data) = try handler(request)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }

    override func stopLoading() {
        
    }
}

struct MockingURLSession {
    static let shared: URLSession = MockingURLSession().getSession()

    private func getSession() -> URLSession {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockingURLProtocol.self]
        return URLSession(configuration: configuration)
    }

    static func resgister(_ data: Data) {
        MockingURLProtocol.requestHandler = { _ in
            return (HTTPURLResponse(), data)
        }
    }

    static func resgister400ErrorCode() {
        MockingURLProtocol.requestHandler = { _ in
            let response = HTTPURLResponse(url: URL(string: "http://testing.com")!,
                                           statusCode: 400,
                                           httpVersion: nil,
                                           headerFields: nil)!
            return (response, Data())
        }
    }
}
