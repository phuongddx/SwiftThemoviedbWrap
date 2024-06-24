//
//  SearchTarget.swift
//  
//
//  Created by PhuongDoan on 24/6/24.
//

import Foundation

// MARK: - Search
enum SearchTarget: TmdbApiTarget {
    case search(request: SearchRequest)

    var path: String {
        switch self {
        case .search:
            return "/search/movie"
        }
    }

    var method: String { "GET" }

    func queryParameters() -> [String: Any]? {
        switch self {
        case .search(let request):
            return request.toUrlQueryParameters()
        }
    }
}
