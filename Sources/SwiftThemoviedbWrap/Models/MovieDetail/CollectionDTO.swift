//
//  CollectionDTO.swift
//
//
//  Created by PhuongDoan on 22/6/24.
//

import Foundation

public struct CollectionDTO: Codable, Equatable {
    public let id: Int
    public let name: String
    public let posterPath: String?
    public let backdropPath: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
}
