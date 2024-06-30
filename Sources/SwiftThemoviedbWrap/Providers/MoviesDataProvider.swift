//
//  MoviesDataProvider.swift
//
//
//  Created by PhuongDoan on 21/6/24.
//

import Foundation
import Combine
import SwiftNetworkWrap

public protocol MoviesDataProvider: AnyObject {
    func getTrendingList(of type: TrendingType,
                         query: MoviesRequestable) -> AnyPublisherResult<MoviesResponse>
    func getMovieList(of type: MovieListType, query: MoviesRequestable) -> AnyPublisherResult<MoviesResponse>
    func getMovieReviewList(query: MovieReviewsRequest) -> AnyPublisherResult<MovieReviewsResponse>
}

public class DefaultMoviesDataProvider: MoviesDataProvider {
    private let clientManager: TmdbNetworkClientManager

    public init(clientManager: TmdbNetworkClientManager = TmdbNetworkClientManager()) {
        self.clientManager = clientManager
    }

    public func getTrendingList(of type: TrendingType,
                                query: MoviesRequestable) -> AnyPublisherResult<MoviesResponse> {
        let target = MoviesTarget.trending(type: type, request: query)
        return clientManager.request(target)
    }

    public func getMovieList(of type: MovieListType,
                             query: any MoviesRequestable) -> AnyPublisherResult<MoviesResponse> {
        let target = MoviesTarget.getMovieList(ofType: type,
                                               request: query)
        return clientManager.request(target)
    }

    public func getMovieReviewList(query: MovieReviewsRequest) -> AnyPublisherResult<MovieReviewsResponse> {
        let target = MoviesTarget.reviews(request: query)
        return clientManager.request(target)
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
