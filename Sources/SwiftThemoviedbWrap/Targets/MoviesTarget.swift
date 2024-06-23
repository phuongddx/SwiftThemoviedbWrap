//
//  MoviesTarget.swift
//  
//
//  Created by PhuongDoan on 21/6/24.
//

import Foundation
import SwiftNetworkWrap

protocol TMDBConfigurationManagerProtocol {
    var accessToken: String { get set }
    var apiKey: String { get set }
    var language: String { get set }

    func validateCredentials() throws
}

public class TMDBConfigurationManager: TMDBConfigurationManagerProtocol {
    static var shared: TMDBConfigurationManagerProtocol = TMDBConfigurationManager()

    private init() {}

    public var accessToken: String = ""
    public var apiKey: String = ""
    public var language: String = NSLocale.preferredLanguages.first ?? "en"

    public func validateCredentials() throws {
        if accessToken.isEmpty || apiKey.isEmpty {
            throw TmdbApiError.invalidCredentials
        }
    }
}

extension ApiTarget {
    var headers: [String : String]? {
        [
            "Content-type": "application/json",
            "Authorization": "Bearer \(TMDBConfigurationManager.shared.accessToken)"
        ]
    }
}

enum MoviesTarget: ApiTarget {
    case todayTrending(request: MoviesRequestable)
    case weekTrending(request: MoviesRequestable)
    case nowPlaying(request: MoviesRequestable)
    case upComing(request: MoviesRequestable)
    case topRated(request: MoviesRequestable)
    case popular(request: MoviesRequestable)
    case recommendations(request: MoviesRecommendationRequestDTO)
    case detail(request: MovieDetailRequestDTO)
    case reviews(request: MovieReviewsRequestDTO)

    var path: String {
        switch self {
        case .reviews(let request):
            return "/movie/\(request.movieId)/reviews"
        case .detail(let request ):
            return "/movie/\(request.movieId)"
        case .popular:
            return "/movie/popular"
        case .nowPlaying:
            return "/movie/now_playing"
        case .upComing:
            return "/movie/upcoming"
        case .todayTrending:
            return "/trending/movie/day"
        case .weekTrending:
            return "/trending/movie/week"
        case .topRated:
            return "/movie/top_rated"
        case .recommendations(let request):
            return "/movie/\(request.movieId)/recommendations"
        }
    }

    var method: String {
        return "GET"
    }

    func queryParameters() -> [String: Any]? {
        switch self {
        case .reviews(let request):
            return request.toUrlQueryParameters()
        case .detail(let requestDetail):
            return requestDetail.toUrlQueryParameters()
        case .todayTrending(let request),
             .weekTrending(let request),
             .topRated(let request),
             .upComing(let request),
             .nowPlaying(let request),
             .popular(let request),
             .recommendations(let request as MoviesRequestable):
            return request.toUrlQueryParameters()
        default:
            return nil
        }
    }

    func body() throws -> Data? {
        return nil
    }

    func urlRequest(baseURL: String) throws -> URLRequest {
        try TMDBConfigurationManager.shared.validateCredentials()
        
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

enum TmdbApiError: Error {
    case invalidCredentials
}
