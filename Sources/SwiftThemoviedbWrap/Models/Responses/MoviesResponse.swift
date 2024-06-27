//
//  File.swift
//  SwiftThemoviedbWrap
//
//  Created by PhuongDoan on 21/6/24.
//

import Foundation

public struct PagedResponse<Model: Codable & Equatable>: Codable, Equatable {
    private enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages"
        case results = "results"
    }

    public let page: Int
    public let totalPages: Int
    public let results: [Model]
}

public struct Movie: Codable, Equatable {
    public let id: Int
    public let title: String?
    public let originalTitle: String?
    public let overview: String?
    public let posterPath: String?
    public let backdropPath: String?
    public let mediaType: String?
    public let adult: Bool
    public let originalLanguage: String?
    public let genreIds: [Int]?
    public let popularity: Double?
    public let releaseDate: String?
    public let video: Bool?
    public let voteAverage: Double
    public let voteCount: Int

    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case mediaType = "media_type"
        case adult
        case originalLanguage = "original_language"
        case genreIds = "genre_ids"
        case popularity
        case releaseDate = "release_date"
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

public typealias MoviesResponse = PagedResponse<Movie>
