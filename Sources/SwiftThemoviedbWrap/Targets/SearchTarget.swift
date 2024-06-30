//
//  SearchTarget.swift
//  
//
//  Created by PhuongDoan on 24/6/24.
//

import Foundation

// MARK: - Search
struct SearchTarget: TmdbApiTarget {
    public var path: String?
    public var queryParams: [String: String]?

    private init(path: String? = nil,
                  queryParams: [String: String]?) {
        self.path = path
        self.queryParams = queryParams?.merging(queryDefaultParams, uniquingKeysWith: { _, new in new })
    }

    static func movie(request: SearchRequest) -> Self {
        SearchTarget(path: "/search/movie",
                     queryParams: request.toQueryParams())
    }

    static func person(request: SearchRequest) -> Self {
        SearchTarget(path: "/search/person",
                     queryParams: request.toQueryParams())
    }
}
