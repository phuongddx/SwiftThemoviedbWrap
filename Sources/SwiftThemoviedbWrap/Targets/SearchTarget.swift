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
    
    var tmdbConfig: TmdbConfiguration
    var path: String
    var method: String = "GET"
    var _queryParameters: [String: Any]?

    init(path: String,
         tmdbConfig: TmdbConfiguration = .default,
         queryParameters: [String: Any]? = nil) {
        self.path = path
        self._queryParameters = queryParameters
        self.tmdbConfig = tmdbConfig
    }
    
    static func movie(request: SearchRequest) -> Self {
        SearchTarget(path: "/search/movie", queryParameters: request.toUrlQueryParameters())
    }

    static func person(request: SearchRequest) -> Self {
        SearchTarget(path: "/search/person", queryParameters: request.toUrlQueryParameters())
    }
}
