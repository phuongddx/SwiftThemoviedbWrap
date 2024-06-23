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

public struct MoviesRecommendationRequestDTO: MoviesRequestable {
    public var page: Int
    public var movieId: Int

    enum CodingKeys: String, CodingKey {
        case page
    }
}

public struct MovieDetailRequestDTO: Encodable {
    public var movieId: Int
    public var additionalResponse: [String]?

    enum CodingKeys: String, CodingKey {
        case additionalResponse = "append_to_response"
    }
}

extension Encodable {
    func toUrlQueryParameters() -> [String: Any]? {
        guard let data = try? JSONEncoder().encode(self),
              let dictionary = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            return nil
        }
        return dictionary.compactMapValues { value -> String? in
            if let stringArray = value as? Array<String> {
                return stringArray.joined(separator: ",").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            }
            if let stringValue = value as? String {
                return stringValue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            }
            return "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        }
    }
}
