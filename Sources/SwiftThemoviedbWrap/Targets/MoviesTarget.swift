//
//  MoviesTarget.swift
//  
//
//  Created by PhuongDoan on 21/6/24.
//

import Foundation
import SwiftNetworkWrap

// MARK: - Movies Target
public enum TrendingType: String {
    case today
    case week
}

public enum MovieListType {
    case nowPlaying
    case upcoming
    case topRated
    case recommendations
    case popular
}

public struct MoviesTarget: TmdbApiTarget {
    public var path: String?
    public var queryParams: [String: String]?

    private init(path: String? = nil,
                  queryParams: [String: String]?) {
        self.path = path
        self.queryParams = queryParams?.merging(queryDefaultParams, uniquingKeysWith: { _, new in new })
    }

    public static func trending(type: TrendingType, request: MoviesRequestable) -> Self {
        MoviesTarget(path: "/trending/movie/\(type.rawValue)",
                     queryParams: request.toQueryParams())
    }

    public static func getMovieList(ofType type: MovieListType, request: MoviesRequestable) -> MoviesTarget {
        switch type {
        case .nowPlaying:
            return MoviesTarget.nowPlaying(request: request)
        case .upcoming:
            return MoviesTarget.upComing(request: request)
        case .topRated:
            return MoviesTarget.topRated(request: request)
        case .popular:
            return MoviesTarget.popular(request: request)
        case .recommendations:
            // Assuming MoviesRequestable can handle recommendations, otherwise adapt this as needed
            // Here we should handle it differently since it requires a movieId
            // I'm assuming you have a different way to get the request for recommendations
            if let recommendationRequest = request as? MoviesRecommendationRequest {
                return MoviesTarget.recommendations(request: recommendationRequest)
            } else {
                fatalError("Invalid request type for recommendations")
            }
        }
    }

    static func nowPlaying(request: MoviesRequestable) -> MoviesTarget {
        MoviesTarget(path: "/movie/now_playing",
                     queryParams: request.toQueryParams())
    }

    static func upComing(request: MoviesRequestable) -> MoviesTarget {
        MoviesTarget(path: "/movie/upcoming",
                     queryParams: request.toQueryParams())
    }

    static func topRated(request: MoviesRequestable) -> MoviesTarget {
        MoviesTarget(path: "/movie/top_rated",
                     queryParams: request.toQueryParams())
    }

    static func popular(request: MoviesRequestable) -> MoviesTarget {
        MoviesTarget(path: "/movie/popular",
                     queryParams: request.toQueryParams())
    }

    public static func recommendations(request: MoviesRecommendationRequest) -> MoviesTarget {
        MoviesTarget(path: "/movie/\(request.movieId)/recommendations",
                     queryParams: request.toQueryParams())
    }

    public static func detail(request: MovieDetailRequest) -> MoviesTarget {
        MoviesTarget(path: "/movie/\(request.movieId)",
                     queryParams: request.toQueryParams())
    }

    public static func reviews(request: MovieReviewsRequest) -> MoviesTarget {
        MoviesTarget(path: "/movie/\(request.movieId)/reviews",
                     queryParams: request.toQueryParams())
    }
}
