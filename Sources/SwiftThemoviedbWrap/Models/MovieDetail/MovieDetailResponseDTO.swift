//
//  MovieDetailResponseDTO.swift
//
//
//  Created by PhuongDoan on 22/6/24.
//

import Foundation

public struct MovieDetailResponseDTO: Codable, Equatable {
    public let adult: Bool
    public let backdropPath: String?
    public let belongsToCollection: CollectionDTO?
    public let budget: Int
    public let genres: [GenreDTO]
    public let homepage: String?
    public let id: Int
    public let imdbId: String?
    public let originCountry: [String]
    public let originalLanguage: String
    public let originalTitle: String
    public let overview: String
    public let popularity: Double
    public let posterPath: String?
    public let productionCompanies: [ProductionCompanyDTO]
    public let productionCountries: [ProductionCountryDTO]
    public let releaseDate: String
    public let revenue: Int
    public let runtime: Int?
    public let spokenLanguages: [SpokenLanguageDTO]
    public let status: String
    public let tagline: String?
    public let title: String
    public let video: Bool
    public let voteAverage: Double
    public let voteCount: Int
    public let videos: VideosDTO
    public let credits: CreditsDTO
    public let recommendations: MoviesResponse
    public let reviews: ReviewsResponseDTO
    
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

public struct GenreDTO: Codable, Equatable {
    public let id: Int
    public let name: String
}

public struct ProductionCompanyDTO: Codable, Equatable {
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

public struct ProductionCountryDTO: Codable, Equatable {
    public let iso31661: String
    public let name: String
    
    private enum CodingKeys: String, CodingKey {
        case iso31661 = "iso_3166_1"
        case name
    }
}

public struct SpokenLanguageDTO: Codable, Equatable {
    public let englishName: String
    public let iso6391: String
    public let name: String
    
    private enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso6391 = "iso_639_1"
        case name
    }
}

public struct VideosDTO: Codable, Equatable {
    public let results: [VideoDTO]
    
    public struct VideoDTO: Codable, Equatable {
        public let iso6391: String
        public let iso31661: String
        public let name: String
        public let key: String
        public let site: String
        public let size: Int
        public let type: String
        public let official: Bool
        public let publishedAt: String
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
}

public struct CreditsDTO: Codable, Equatable {
    public let cast: [CastDTO]
    public let crew: [CrewDTO]
    
    public struct CastDTO: Codable, Equatable {
        public let adult: Bool
        public let gender: Int
        public let id: Int
        public let knownForDepartment: String
        public let name: String
        public let originalName: String
        public let popularity: Double
        public let profilePath: String?
        public let castId: Int
        public let character: String
        public let creditId: String
        public let order: Int
        
        private enum CodingKeys: String, CodingKey {
            case adult
            case gender
            case id
            case knownForDepartment = "known_for_department"
            case name
            case originalName = "original_name"
            case popularity
            case profilePath = "profile_path"
            case castId = "cast_id"
            case character
            case creditId = "credit_id"
            case order
        }
    }
    
    public struct CrewDTO: Codable, Equatable {
        public let adult: Bool
        public let gender: Int
        public let id: Int
        public let knownForDepartment: String
        public let name: String
        public let originalName: String
        public let popularity: Double
        public let profilePath: String?
        public let creditId: String
        public let department: String
        public let job: String
        
        private enum CodingKeys: String, CodingKey {
            case adult
            case gender
            case id
            case knownForDepartment = "known_for_department"
            case name
            case originalName = "original_name"
            case popularity
            case profilePath = "profile_path"
            case creditId = "credit_id"
            case department
            case job
        }
    }
}

public struct ReviewsResponseDTO: Codable, Equatable {
    public let page: Int
    public let results: [ReviewDTO]
    public let totalPages: Int
    public let totalResults: Int
    
    private enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
    public struct ReviewDTO: Codable, Equatable {
        public let author: String
        public let authorDetails: AuthorDetailsDTO
        public let content: String
        public let createdAt: String
        public let id: String
        public let updatedAt: String
        public let url: String
        
        private enum CodingKeys: String, CodingKey {
            case author
            case authorDetails = "author_details"
            case content
            case createdAt = "created_at"
            case id
            case updatedAt = "updated_at"
            case url
        }
        
        public struct AuthorDetailsDTO: Codable, Equatable {
            public let name: String
            public let username: String
            public let avatarPath: String?
            public let rating: Double?
            
            private enum CodingKeys: String, CodingKey {
                case name
                case username
                case avatarPath = "avatar_path"
                case rating
            }
        }
    }
}
