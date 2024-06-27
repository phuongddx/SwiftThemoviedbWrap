//
//  MoviesDataProvider.swift
//
//
//  Created by PhuongDoan on 21/6/24.
//

import Foundation
import Combine
import SwiftNetworkWrap

public protocol MoviesDataProvider: TmdbNetworkWrapProvider {
    func getTrendingList(type: TrendingType,
                         request: MoviesRequestable) -> AnyPublisher<MoviesResponse, Error>
    func getMovieList(type: MovieListType,
                      request: MoviesRequestable) -> AnyPublisher<MoviesResponse, Error>
    func getMovieDetails(request: MovieDetailRequest) -> AnyPublisher<MovieDetailResponse, Error>
    func getMovieReviewList(request: MovieReviewsRequest) -> AnyPublisher<MovieReviewsResponse, Error>
}

public enum TrendingType {
    case today
    case week
}

public enum MovieListType {
    case nowPlaying
    case upcoming
    case topRated
    case recommendations

    func target(request: MoviesRequestable) -> TmdbApiTarget {
        switch self {
        case .nowPlaying:
            return MoviesTarget.nowPlaying(request: request)
        case .upcoming:
            return MoviesTarget.upComing(request: request)
        case .topRated:
            return MoviesTarget.topRated(request: request)
        case .recommendations:
            return MoviesTarget.recommendations(request: request as! MoviesRecommendationRequest)
        }
    }
}

public final class DefaultMoviesDataProvider: MoviesDataProvider {
    public var urlSession: URLSession

    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }

    public func getTrendingList(type: TrendingType,
                                request: MoviesRequestable) -> AnyPublisher<MoviesResponse, Error> {
        var target: TmdbApiTarget
        switch type {
        case .today:
            target = MoviesTarget.todayTrending(request: request)
        case .week:
            target = MoviesTarget.weekTrending(request: request)
        }
        return load(target, httpCodes: .success)
    }
    
    public func getMovieList(type: MovieListType,
                             request: MoviesRequestable) -> AnyPublisher<MoviesResponse, Error> {
        load(type.target(request: request))
    }

    public func getMovieDetails(request: MovieDetailRequest) -> AnyPublisher<MovieDetailResponse, any Error> {
        load(MoviesTarget.detail(request: request))
    }

    public func getMovieReviewList(request: MovieReviewsRequest) -> AnyPublisher<MovieReviewsResponse, Error> {
        load(MoviesTarget.reviews(request: request))
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
