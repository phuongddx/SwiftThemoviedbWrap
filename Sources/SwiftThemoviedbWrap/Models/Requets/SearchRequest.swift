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

public struct SearchRequest: MoviesRequestable {
    public let query: String
    public var page: Int
}

public struct DefaultMoviesRequest: MoviesRequestable {
    public var page: Int = 1
}

public struct MoviesRecommendationRequest: MoviesRequestable {
    public var page: Int
    public var movieId: Int

    enum CodingKeys: String, CodingKey {
        case page
    }
}

public protocol MovieIdentifierRequestable: Encodable {
    typealias Identifier = Int
    var movieId: Identifier { get }
}

public struct MovieReviewsRequest: MovieIdentifierRequestable {
    public var movieId: Identifier
    public var page: Int

    enum CodingKeys: String, CodingKey {
        case page
    }
}

public struct MovieDetailRequest: MovieIdentifierRequestable {
    public var movieId: Identifier
    public var additionalResponse: [String]?

    enum CodingKeys: String, CodingKey {
        case additionalResponse = "append_to_response"
    }
}

extension Encodable {
    func toQueryParams() -> [String: String]? {
        guard let data = try? JSONEncoder().encode(self),
              let dictionary = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            return nil
        }
        return dictionary.compactMapValues { value -> String? in
            switch value {
            case let stringArray as [String]:
                return stringArray.joined(separator: ",")
            case let stringValue as String:
                return stringValue
            default:
                return String(describing: value)
            }
        }
    }
}
