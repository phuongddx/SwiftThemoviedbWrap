//
//  SearchDataProvider.swift
//
//
//  Created by PhuongDoan on 24/6/24.
//

import Foundation
import Combine

public protocol SearchDataProvider: TmdbNetworkWrapProvider {
    func movies(request: SearchRequest) -> AnyPublisher<MoviesResponse, Error>
    func persons(_ request: SearchRequest) -> AnyPublisher<PersonPagedResponse, Error>
}

public final class DefaultSearchDataProvider: SearchDataProvider {
    public var urlSession: URLSession

    public init(urlSession: URLSession) {
        self.urlSession = urlSession
    }

    public func movies(request: SearchRequest) -> AnyPublisher<MoviesResponse, Error> {
        load(SearchTarget.movie(request: request))
    }

    public func persons(_ request: SearchRequest) -> AnyPublisher<PersonPagedResponse, Error> {
        load(SearchTarget.person(request: request))
    }
}

extension URLSession {
    static let sharedInstance: URLSession = URLSession.configuredURLSession()
}
