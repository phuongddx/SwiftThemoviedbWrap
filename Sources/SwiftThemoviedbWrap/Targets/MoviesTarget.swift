//
//  MoviesTarget.swift
//  
//
//  Created by PhuongDoan on 21/6/24.
//

import Foundation
import SwiftNetworkWrap

open class TmdbConfiguration {
    open var accessToken: String
    open var apiKey: String
    open var language: String = NSLocale.preferredLanguages.first ?? "en-US"

    init(accessToken: String = "",
         apiKey: String = "",
         language: String = "en-US") {
        self.accessToken = accessToken
        self.apiKey = apiKey
        self.language = language
    }

    static var `default`: TmdbConfiguration {
        TmdbConfiguration(accessToken: "123123123")
    }
}

protocol TmdbApiTarget: ApiTarget {
    var tmdbConfig: TmdbConfiguration { get }

    func validationTmdbConfiguraiton() throws
}

extension TmdbApiTarget {
    var headers: [String : String]? {
        [
            "Content-type": "application/json",
            "Authorization": "Bearer \(tmdbConfig.accessToken)"
        ]
    }

    func validationTmdbConfiguraiton() throws {
        if tmdbConfig.accessToken.isEmpty && tmdbConfig.apiKey.isEmpty {
            throw TmdbApiError.invalidCredentials
        }
    }

    func body() throws -> Data? {
        return nil
    }

    func urlRequest(baseURL: String) throws -> URLRequest {
        guard var urlComponents = URLComponents(string: baseURL) else {
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
    func queryParameters() -> [String : Any]? {
        _queryParameters
    }

    var tmdbConfig: TmdbConfiguration
    var path: String
    var method: String = "GET"
    var _queryParameters: [String: Any]?

    init(path: String,
         tmdbConfig: TmdbConfiguration,
         queryParameters: [String: Any]? = nil) {
        self.path = path
        self._queryParameters = queryParameters
        self.tmdbConfig = tmdbConfig
    }
    
    static func todayTrending(request: MoviesRequestable,
                              tmdbConfig: TmdbConfiguration = .default) -> MoviesTarget {
        return MoviesTarget(path: "/trending/movie/day",
                            tmdbConfig: tmdbConfig,
                            queryParameters: request.toUrlQueryParameters())
    }

    static func weekTrending(request: MoviesRequestable,
                             tmdbConfig: TmdbConfiguration = .default) -> MoviesTarget {
        return MoviesTarget(path: "/trending/movie/week",
                            tmdbConfig: tmdbConfig,
                            queryParameters: request.toUrlQueryParameters())
    }

    static func nowPlaying(request: MoviesRequestable,
                           tmdbConfig: TmdbConfiguration = .default) -> MoviesTarget {
        return MoviesTarget(path: "/movie/now_playing",
                            tmdbConfig: tmdbConfig,
                            queryParameters: request.toUrlQueryParameters())
    }

    static func upComing(request: MoviesRequestable,
                         tmdbConfig: TmdbConfiguration = .default) -> MoviesTarget {
        return MoviesTarget(path: "/movie/upcoming",
                            tmdbConfig: tmdbConfig,
                            queryParameters: request.toUrlQueryParameters())
    }

    static func topRated(request: MoviesRequestable,
                         tmdbConfig: TmdbConfiguration = .default) -> MoviesTarget {
        return MoviesTarget(path: "/movie/top_rated",
                            tmdbConfig: tmdbConfig,
                            queryParameters: request.toUrlQueryParameters())
    }

    static func popular(request: MoviesRequestable,
                        tmdbConfig: TmdbConfiguration = .default) -> MoviesTarget {
        return MoviesTarget(path: "/movie/popular",
                            tmdbConfig: tmdbConfig,
                            queryParameters: request.toUrlQueryParameters())
    }

    static func recommendations(request: MoviesRecommendationRequest,
                                tmdbConfig: TmdbConfiguration = .default) -> MoviesTarget {
        return MoviesTarget(path: "/movie/\(request.movieId)/recommendations",
                            tmdbConfig: tmdbConfig,
                            queryParameters: request.toUrlQueryParameters())
    }

    static func detail(request: MovieDetailRequest,
                       tmdbConfig: TmdbConfiguration = .default) -> MoviesTarget {
        return MoviesTarget(path: "/movie/\(request.movieId)",
                            tmdbConfig: tmdbConfig,
                            queryParameters: request.toUrlQueryParameters())
    }

    static func reviews(request: MovieReviewsRequest,
                        tmdbConfig: TmdbConfiguration = .default) -> MoviesTarget {
        return MoviesTarget(path: "/movie/\(request.movieId)/reviews",
                            tmdbConfig: tmdbConfig,
                            queryParameters: request.toUrlQueryParameters())
    }
}

enum TmdbApiError: Error {
    case invalidCredentials
}
