//
//  SearchTarget.swift
//  
//
//  Created by PhuongDoan on 24/6/24.
//

import Foundation

// MARK: - Search
enum SearchTarget: TmdbApiTarget {
    case movie(request: SearchRequest)
    case person(request: SearchRequest)

    var path: String {
        switch self {
        case .movie:
            return "/search/movie"
        case .person:
            return "/search/person"
        }
    }

    var method: String { "GET" }

    func queryParameters() -> [String: Any]? {
        switch self {
        case .movie(let request),
                .person(let request):
            return request.toUrlQueryParameters()
        }
    }
}
