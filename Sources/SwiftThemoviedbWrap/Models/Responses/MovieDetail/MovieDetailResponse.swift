//
//  MovieDetailResponseDTO.swift
//
//
//  Created by PhuongDoan on 22/6/24.
//

import Foundation

public struct MovieDetailResponse: Codable, Equatable {
    public let adult: Bool
    public let backdropPath: String?
    public let belongsToCollection: CollectionModel?
    public let budget: Int?
    public let genres: [Genre]
    public let homepage: String?
    public let id: Int
    public let imdbId: String?
    public let originCountry: [String]
    public let originalLanguage: String?
    public let originalTitle: String?
    public let overview: String?
    public let popularity: Double?
    public let posterPath: String?
    public let productionCompanies: [ProductionCompany]?
    public let productionCountries: [ProductionCountry]?
    public let releaseDate: String?
    public let revenue: Int?
    public let runtime: Int?
    public let spokenLanguages: [SpokenLanguage]?
    public let status: String?
    public let tagline: String?
    public let title: String?
    public let video: Bool?
    public let voteAverage: Double
    public let voteCount: Int?
    public let videos: Videos?
    public let credits: Credits?
    public let recommendations: MoviesResponse?
    public let reviews: MovieReviewsResponse?

    private enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case belongsToCollection = "belongs_to_collection"
        case budget
        case genres
        case homepage
        case id
        case imdbId = "imdb_id"
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue
        case runtime
        case spokenLanguages = "spoken_languages"
        case status
        case tagline
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case videos
        case credits
        case recommendations
        case reviews
    }
}

public struct Genre: Codable, Equatable {
    public let id: Int
    public let name: String
}

public struct ProductionCompany: Codable, Equatable {
    public let id: Int
    public let logoPath: String?
    public let name: String
    public let originCountry: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}

public struct ProductionCountry: Codable, Equatable {
    public let iso31661: String
    public let name: String
    
    private enum CodingKeys: String, CodingKey {
        case iso31661 = "iso_3166_1"
        case name
    }
}

public struct SpokenLanguage: Codable, Equatable {
    public let englishName: String
    public let iso6391: String
    public let name: String
    
    private enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso6391 = "iso_639_1"
        case name
    }
}

public struct Videos: Codable, Equatable {
    public let results: [Video]
}

public struct Video: Codable, Equatable {
    public let iso6391: String?
    public let iso31661: String?
    public let name: String?
    public let key: String?
    public let site: String?
    public let size: Int
    public let type: String?
    public let official: Bool
    public let publishedAt: String?
    public let id: String
    
    private enum CodingKeys: String, CodingKey {
        case iso6391 = "iso_639_1"
        case iso31661 = "iso_3166_1"
        case name
        case key
        case site
        case size
        case type
        case official
        case publishedAt = "published_at"
        case id
    }
}

public struct Credits: Codable, Equatable {
    public let cast: [Person]
    public let crew: [Person]
}
