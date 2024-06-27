//
//  MoviesTarget.swift
//  
//
//  Created by PhuongDoan on 21/6/24.
//

import Foundation
import SwiftNetworkWrap

public struct NetworkWrapConfigurationTmdb {
    private init() {}

    public static var apiKey: String = ""
    public static var accessToken: String = ""
    public static var language: String = NSLocale.preferredLanguages.first ?? "en-US"
}

public protocol TmdbApiTarget: ApiTarget {
    var baseURL: URL { get }

    func buildURLRequest() throws -> URLRequest
}

extension TmdbApiTarget {
    var headers: [String: String]? {
        [
            "Content-type": "application/json",
            "Authorization": "Bearer \(NetworkWrapConfigurationTmdb.accessToken)"
        ]
    }

    func body() throws -> Data? {
        return nil
    }

    func buildURLRequest() throws -> URLRequest {
        guard var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: false) else {
            throw ApiError.invalidUrl
        }
        urlComponents.path = path
        if let queryItems = queryParameters() {
            urlComponents.queryItems = queryItems.map { URLQueryItem(name: $0.key, value: "\($0.value)")}
        }
        guard let url = urlComponents.url else {
            throw ApiError.invalidUrl
        }
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.allHTTPHeaderFields = headers
        request.httpBody = try body()
        return request
    }
}

struct MoviesTarget: TmdbApiTarget {
    func queryParameters() -> [String: Any]? {
        let queryDefault: [String: Any] = [
            "api_key": NetworkWrapConfigurationTmdb.apiKey,
            "language": NetworkWrapConfigurationTmdb.language
        ]
        return _queryParameters?.merging(queryDefault, uniquingKeysWith: { _,new in new })
    }

    var baseURL: URL {
        URL(string: "https://api.themoviedb.org/3")!
    }
    var path: String
    var method: String = "GET"
    var _queryParameters: [String: Any]?

    init(path: String,
         queryParameters: [String: Any]? = nil) {
        self.path = path
        self._queryParameters = queryParameters
    }

    static func todayTrending(request: MoviesRequestable) -> Self {
        MoviesTarget(path: "/trending/movie/day",
                     queryParameters: request.toUrlQueryParameters())
    }

    static func weekTrending(request: MoviesRequestable) -> Self {
        MoviesTarget(path: "/trending/movie/week",
                     queryParameters: request.toUrlQueryParameters())
    }

    static func nowPlaying(request: MoviesRequestable) -> MoviesTarget {
        return MoviesTarget(path: "/movie/now_playing",
                            queryParameters: request.toUrlQueryParameters())
    }

    static func upComing(request: MoviesRequestable) -> MoviesTarget {
        return MoviesTarget(path: "/movie/upcoming",
                            queryParameters: request.toUrlQueryParameters())
    }

    static func topRated(request: MoviesRequestable) -> MoviesTarget {
        return MoviesTarget(path: "/movie/top_rated",
                            queryParameters: request.toUrlQueryParameters())
    }

    static func popular(request: MoviesRequestable) -> MoviesTarget {
        return MoviesTarget(path: "/movie/popular",
                            queryParameters: request.toUrlQueryParameters())
    }

    static func recommendations(request: MoviesRecommendationRequest) -> MoviesTarget {
        return MoviesTarget(path: "/movie/\(request.movieId)/recommendations",
                            queryParameters: request.toUrlQueryParameters())
    }

    static func detail(request: MovieDetailRequest) -> MoviesTarget {
        return MoviesTarget(path: "/movie/\(request.movieId)",
                            queryParameters: request.toUrlQueryParameters())
    }

    static func reviews(request: MovieReviewsRequest) -> MoviesTarget {
        return MoviesTarget(path: "/movie/\(request.movieId)/reviews",
                            queryParameters: request.toUrlQueryParameters())
    }
}

enum TmdbApiError: Error {
    case invalidCredentials
}
