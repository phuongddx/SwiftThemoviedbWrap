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
    public var rating: Double

    enum CodingKeys: String, CodingKey {
        case name
        case username
        case avatarPath = "avatar_path"
        case rating
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.username = try container.decodeIfPresent(String.self, forKey: .username)
        self.avatarPath = (try? container.decodeIfPresent(String.self, forKey: .avatarPath)) ?? ""
        self.rating = (try container.decodeIfPresent(Double.self, forKey: .rating)) ?? 0.0
    }
}
