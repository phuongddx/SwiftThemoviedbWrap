//
//  MoviesDataProvider.swift
//
//
//  Created by PhuongDoan on 21/6/24.
//

import Foundation
import Combine
import SwiftNetworkWrap

public protocol NetworkWrapProvider {
    var sessionManager: NetworkSessionManager { get }
}
extension NetworkWrapProvider {
    func request<Value: Decodable>(_ target: ApiTarget) -> AnyPublisher<Value, Error> {
        sessionManager.call(target)
    }
}

public class DefaultNetworkWrapProvider: NetworkWrapProvider {
    public var sessionManager: NetworkSessionManager

    init(sessionManager: NetworkSessionManager = DefaultNetworkSessionManager(baseURL: "")) {
        self.sessionManager = sessionManager
    }
}

public protocol MoviesDataProvider {
    func getTodayTrendingList() -> AnyPublisher<MoviesResponseDTO, Error>
}

public final class DefaultMoviesDataProvider: MoviesDataProvider {
    public let provider: NetworkWrapProvider

    init(provider: NetworkWrapProvider = DefaultNetworkWrapProvider()) {
        self.provider = provider
    }

    public func getTodayTrendingList() -> AnyPublisher<MoviesResponseDTO, Error> {
        let target = MoviesTarget.todayTrending
        return provider.request(target)
    }
}

public extension Publisher {
    func sinkToResult(_ result: @escaping (Result<Output, Failure>) -> Void) -> AnyCancellable {
        sink(receiveCompletion: { completion in
            switch completion {
            case let .failure(error):
                result(.failure(error))
            default:
                break
            }
        }, receiveValue: { value in
            result(.success(value))
        })
    }
}
