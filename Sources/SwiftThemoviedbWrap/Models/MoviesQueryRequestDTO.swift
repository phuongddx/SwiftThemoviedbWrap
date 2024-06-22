//
//  MoviesQueryRequestDTO.swift
//  
//
//  Created by PhuongDoan on 21/6/24.
//

import Foundation

public protocol MoviesRequestable: Encodable {
    var page: Int { get set }
}

public struct MoviesQueryRequestDTO: MoviesRequestable {
    public let query: String
    public var page: Int
}

public struct DefaultMoviesRequestDTO: MoviesRequestable {
    public var page: Int

    public init(page: Int = 1) {
        self.page = page
    }
}

public struct MoviesRecommendationREquestDTO: MoviesRequestable {
    public var page: Int
    public var movieId: Int
}

extension Encodable {
    func toDictionary() -> [String: Any]? {
        guard let data = try? JSONEncoder().encode(self),
              let jsonData = try? JSONSerialization.jsonObject(with: data) else {
            return nil
        }
        return jsonData as? [String: Any]
    }
}
