//
//  NetworkWrapProvider.swift
//  
//
//  Created by PhuongDoan on 22/6/24.
//

import Foundation
import Combine
import SwiftNetworkWrap

public protocol NetworkWrapProvider {
    var sessionManager: NetworkSessionManager { get }
}

extension NetworkWrapProvider {
    func request<Value: Decodable>(_ target: TmdbApiTarget) -> AnyPublisher<Value, Error> {
        sessionManager.call(target)
    }
}

public class TmdbNetworkSessionManager {
    public var session: URLSession
    public var bgQueue: DispatchQueue

    init(session: URLSession = .configuredURLSession(),
         bgQueue: DispatchQueue = DispatchQueue(label: "themoviedb_queue")) {
        self.session = session
        self.bgQueue = bgQueue
    }

    func request<Response: Decodable>(_ target: TmdbApiTarget) -> AnyPublisher<Response, Error> {
        do {
            let urlRequest = try target.buildURLRequest()
            return session.dataTaskPublisher(for: urlRequest)
                .requestJSON(httpCodes: .success)
                .eraseToAnyPublisher()
        } catch {
            return Fail<Response, Error>(error: error).eraseToAnyPublisher()
        }
    }
}

public class TmdbNetworkWrapProvider {
    public var sessionManager: TmdbNetworkSessionManager

    init(sessionManager: TmdbNetworkSessionManager = TmdbNetworkSessionManager()) {
        self.sessionManager = sessionManager
    }

    func request<Response: Decodable>(_ target: TmdbApiTarget) -> AnyPublisher<Response, Error> {
        sessionManager.request(target)
    }
}

extension Publisher where Output == URLSession.DataTaskPublisher.Output {
    func requestData(httpCodes: HTTPCodes = .success) -> AnyPublisher<Data, Error> {
        return tryMap {
            assert(!Thread.isMainThread)
            guard let code = ($0.response as? HTTPURLResponse)?.statusCode else {
                throw ApiError.unexpectedResponse
            }
            guard httpCodes.contains(code) else {
                throw ApiError.httpCode(code)
            }
            return $0.data
        }
        .extractUnderlyingError()
        .eraseToAnyPublisher()
    }
}

fileprivate extension Publisher where Output == URLSession.DataTaskPublisher.Output {
    func requestJSON<Response: Decodable>(httpCodes: HTTPCodes) -> AnyPublisher<Response, Error> {
        return requestData(httpCodes: httpCodes)
            .decode(type: Response.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
