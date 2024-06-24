//
//  File.swift
//  
//
//  Created by PhuongDoan on 24/6/24.
//

import Foundation

public typealias PersonPagedResponse = PagedResponse<Person>

public struct Person: Codable, Equatable {
    public let adult: Bool
    public let gender: Int
    public let id: Int
    public let knownForDepartment: String?
    public let name: String?
    public let originalName: String?
    public let popularity: Double
    public let profilePath: String?
    public let castId: Int?
    public let character: String?
    public let creditId: String?
    public let order: Int?
    public let knownForMovies: [Movie]?
    
    private enum CodingKeys: String, CodingKey {
        case adult
        case gender
        case id
        case knownForDepartment = "known_for_department"
        case knownForMovies = "known_for"
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
