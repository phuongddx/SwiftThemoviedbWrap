//
//  NetworkWrapProvider.swift
//  
//
//  Created by PhuongDoan on 22/6/24.
//

import Foundation
import Combine
import SwiftNetworkWrap

protocol TmdbNetworkWrapProvider {
    var session: URLSession { get }
    var baseURL: URL { get }

    func request<Response: Decodable>(_ target: TmdbApiTarget, httpCodes: HTTPCodes) -> AnyPublisher<Response, Error>
}
extension TmdbNetworkWrapProvider {
    func request<Response>(_ target: any TmdbApiTarget,
                           httpCodes: HTTPCodes = .success) -> AnyPublisher<Response, any Error> where Response: Decodable {
        do {
            let urlRequest = try target.buildURLRequest()
            return session.dataTaskPublisher(for: urlRequest)
                .requestJSON(httpCodes: .success)
                .eraseToAnyPublisher()
        } catch {
            return Fail<Response, Error>(error: error)
                .eraseToAnyPublisher()
        }
    }
}

class DefaultTmdbNetworkWrapProvider: TmdbNetworkWrapProvider {
    var session: URLSession
    var baseURL: URL

    init(session: URLSession = .configuredURLSession(),
         baseURL: URL = URL(string: "https://api.themoviedb.org/3")!) {
        self.session = session
        self.baseURL = baseURL
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
