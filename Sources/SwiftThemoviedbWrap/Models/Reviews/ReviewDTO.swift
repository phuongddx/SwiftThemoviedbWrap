//
//  File.swift
//  
//
//  Created by PhuongDoan on 23/6/24.
//

import Foundation

public typealias MovieReviewsResponseDTO = PagedResponseDTO<ReviewDTO>

public struct ReviewDTO: Codable, Equatable {
    public var author: String?
    public var authorDetails: AuthorDetailsDTO?
    public var content: String?
    public var createdAt: String?
    public var id: String
    public var updatedAt: String?
    public var url: String?

    public init(author: String,
                authorDetails: AuthorDetailsDTO,
                content: String,
                createdAt: String,
                id: String,
                updatedAt: String,
                url: String) {
        self.author = author
        self.authorDetails = authorDetails
        self.content = content
        self.createdAt = createdAt
        self.id = id
        self.updatedAt = updatedAt
        self.url = url
    }
}
