//
//  AuthorDetailsDTO.swift
//  
//
//  Created by PhuongDoan on 23/6/24.
//

import Foundation

public struct AuthorDetailsDTO: Codable, Equatable {
    public var name: String?
    public var username: String?
    public var avatarPath: String?
    public var rating: Double?

    public init(name: String?,
                username: String,
                avatarPath: String?,
                rating: Double?) {
        self.name = name
        self.username = username
        self.avatarPath = avatarPath
        self.rating = rating
    }
}
