//
//  SearchDataProvider.swift
//
//
//  Created by PhuongDoan on 24/6/24.
//

import Foundation
import Combine

public protocol SearchDataProvider {
    func movies(request: SearchRequest) -> AnyPublisher<MoviesResponse, Error>
    func persons(_ request: SearchRequest) -> AnyPublisher<PersonPagedResponse, Error>
}

public final class DefaultSearchDataProvider: SearchDataProvider {
    let provider: NetworkWrapProvider

    init(provider: NetworkWrapProvider = DefaultNetworkWrapProvider()) {
        self.provider = provider
    }

    public func movies(request: SearchRequest) -> AnyPublisher<MoviesResponse, Error> {
        provider.request(SearchTarget.movie(request: request))
    }

    public func persons(_ request: SearchRequest) -> AnyPublisher<PersonPagedResponse, Error> {
        provider.request(SearchTarget.person(request: request))
    }
}
