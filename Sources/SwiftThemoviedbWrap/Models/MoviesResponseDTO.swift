//
//  File.swift
//  SwiftThemoviedbWrap
//
//  Created by PhuongDoan on 21/6/24.
//

import Foundation

public struct PagedResponseDTO<ModelDTO: Codable & Equatable>: Codable, Equatable {
    private enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages"
        case results = "results"
    }

    public let page: Int
    public let totalPages: Int
    public let results: [ModelDTO]
}

public struct MovieDTO: Codable, Equatable {
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        case overview
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }

    public let id: Int
    public let title: String?
    public let posterPath: String?
    public let overview: String?
    public let releaseDate: String?
    public let voteAverage: Double?
}

public typealias MoviesResponseDTO = PagedResponseDTO<MovieDTO>
