//
//  File.swift
//  
//
//  Created by PhuongDoan on 21/6/24.
//

import Foundation

extension URLSession {
    static var mockedResponseOnly: URLSession {
        let config = URLSessionConfiguration.default
        config.protocolClasses = [RequestMocking.self, RequestBlocking.self]
        config.timeoutIntervalForRequest = 1
        config.timeoutIntervalForResource = 1
        return URLSession(configuration: config)
    }
}

final class RequestMocking: URLProtocol {
    override class func canInit(with request: URLRequest) -> Bool {
        return mock(for: request) != nil
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override class func requestIsCacheEquivalent(_ a: URLRequest, to b: URLRequest) -> Bool {
        false
    }
}

extension RequestMocking {
    private final class MocksContainer: @unchecked Sendable {
        var mocks: [MockedResponse] = []
    }
    static private let container = MocksContainer()
    static private let lock = NSLock()

    static func add(mock: MockedResponse) {
        lock.withLock {
            container.mocks.append(mock)
        }
    }
    
    static func removeAllMocks() {
        lock.withLock {
            container.mocks.removeAll()
        }
    }
    
    static private func mock(for request: URLRequest) -> MockedResponse? {
        return lock.withLock {
            container.mocks.first { $0.url == request.url }
        }
    }
}

// MARK: - RequestBlocking

private class RequestBlocking: URLProtocol {
    enum Error: Swift.Error {
        case requestBlocked
    }

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        DispatchQueue(label: "").async {
            self.client?.urlProtocol(self, didFailWithError: Error.requestBlocked)
        }
    }
    override func stopLoading() { }
}
