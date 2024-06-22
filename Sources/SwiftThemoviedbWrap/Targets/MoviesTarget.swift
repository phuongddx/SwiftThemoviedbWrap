//
//  MoviesTarget.swift
//  
//
//  Created by PhuongDoan on 21/6/24.
//

import Foundation
import SwiftNetworkWrap

enum MoviesTarget: ApiTarget {
    case todayTrending(request: MoviesRequestable)
    case weekTrending(request: MoviesRequestable)
    case nowPlaying(request: MoviesRequestable)
    case upComing(request: MoviesRequestable)
    case topRated(request: MoviesRequestable)
    case popular(request: MoviesRequestable)
    case recommendations(request: MoviesRecommendationREquestDTO)

    var path: String {
        switch self {
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

    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }

    func queryParameters() -> [String: Any]? {
        switch self {
        case .todayTrending(let request),
             .weekTrending(let request),
             .topRated(let request),
             .upComing(let request),
             .nowPlaying(let request),
             .popular(let request),
             .recommendations(let request as MoviesRequestable):
            return request.toDictionary()
        }
    }

    func body() throws -> Data? {
        return nil
    }
}
