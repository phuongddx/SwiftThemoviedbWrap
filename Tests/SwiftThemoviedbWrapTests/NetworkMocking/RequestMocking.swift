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
        config.protocolClasses = [RequestMocking.self]
        config.timeoutIntervalForRequest = 5
        config.timeoutIntervalForResource = 5
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
        return false
    }

    override func startLoading() {
        if let mock = RequestMocking.mock(for: request),
           let url = request.url,
           let response = mock.customResponse ?? HTTPURLResponse(url: url,
                                                                 statusCode: mock.httpCode,
                                                                 httpVersion: "HTTP/1.1",
                                                                 headerFields: mock.headers) {
            DispatchQueue.main.asyncAfter(deadline: .now() + mock.loadingTime) { [weak self] in
                guard let self else {
                    return
                }
                self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
                switch mock.result {
                case let .success(data):
                    self.client?.urlProtocol(self, didLoad: data)
                    self.client?.urlProtocolDidFinishLoading(self)
                case let .failure(error):
                    let failure = NSError(domain: NSURLErrorDomain, code: 1,
                                          userInfo: [NSUnderlyingErrorKey: error])
                    self.client?.urlProtocol(self, didFailWithError: failure)
                }
            }
        }
    }

    override func stopLoading() { }
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
