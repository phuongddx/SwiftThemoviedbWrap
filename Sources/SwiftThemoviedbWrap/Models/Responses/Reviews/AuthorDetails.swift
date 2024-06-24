//
//  AuthorDetailsDTO.swift
//  
//
//  Created by PhuongDoan on 23/6/24.
//

import Foundation

public struct AuthorDetails: Codable, Equatable {
    public var name: String?
    public var username: String?
    public var avatarPath: String?
    public var rating: Double?

    enum CodingKeys: String, CodingKey {
        case name
        case username
        case avatarPath = "avatar_path"
        case rating
    }
}
