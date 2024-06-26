//
//  SearchTarget.swift
//  
//
//  Created by PhuongDoan on 24/6/24.
//

import Foundation

// MARK: - Search
struct SearchTarget: TmdbApiTarget {
    func queryParameters() -> [String : Any]? {
        _queryParameters
    }

    var baseURL: URL {
        URL(string: "https://api.themoviedb.org/3")!
    }
    var path: String
    let method: String
    var _queryParameters: [String: Any]?

    init(path: String,
         method: String = "GET",
         queryParameters: [String: Any]? = nil) {
        self.path = path
        self.method = method
        self._queryParameters = queryParameters
    }
    
    static func movie(request: SearchRequest) -> Self {
        SearchTarget(path: "/search/movie", queryParameters: request.toUrlQueryParameters())
    }

    static func person(request: SearchRequest) -> Self {
        SearchTarget(path: "/search/person", queryParameters: request.toUrlQueryParameters())
    }
}
