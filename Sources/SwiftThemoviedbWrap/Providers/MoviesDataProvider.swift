//
//  MoviesDataProvider.swift
//
//
//  Created by PhuongDoan on 21/6/24.
//

import Foundation
import Combine
import SwiftNetworkWrap

public protocol MoviesDataProvider {
    func getTrendingList(type: TrendingType, requestDTO: MoviesRequestable) -> AnyPublisher<MoviesResponseDTO, Error>
    func getMovieList(type: MovieListType, requestDto: MoviesRequestable) -> AnyPublisher<MoviesResponseDTO, Error>
    func getMovieDetails(requestDto: MovieDetailRequestDTO) -> AnyPublisher<MovieDetailResponseDTO, Error>
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

    func target(request: MoviesRequestable) -> ApiTarget {
        switch self {
        case .nowPlaying:
            return MoviesTarget.nowPlaying(request: request)
        case .upcoming:
            return MoviesTarget.upComing(request: request)
        case .topRated:
            return MoviesTarget.topRated(request: request)
        case .recommendations:
            return MoviesTarget.recommendations(request: request as! MoviesRecommendationRequestDTO)
        }
    }
}

public final class DefaultMoviesDataProvider: MoviesDataProvider {
    public let provider: NetworkWrapProvider

    init(provider: NetworkWrapProvider = DefaultNetworkWrapProvider()) {
        self.provider = provider
    }

    public func getTrendingList(type: TrendingType,
                                requestDTO: MoviesRequestable) -> AnyPublisher<MoviesResponseDTO, Error> {
        var target: ApiTarget
        switch type {
        case .today:
            target = MoviesTarget.todayTrending(request: requestDTO)
        case .week:
            target = MoviesTarget.weekTrending(request: requestDTO)
        }
        return provider.request(target)
    }
    
    public func getMovieList(type: MovieListType,
                             requestDto: MoviesRequestable) -> AnyPublisher<MoviesResponseDTO, Error> {
        provider.request(type.target(request: requestDto))
    }

    public func getMovieDetails(requestDto: MovieDetailRequestDTO) -> AnyPublisher<MovieDetailResponseDTO, any Error> {
        provider.request(MoviesTarget.detail(request: requestDto))
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
