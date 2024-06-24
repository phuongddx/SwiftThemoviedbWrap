//
//  File.swift
//  
//
//  Created by PhuongDoan on 23/6/24.
//

import Foundation

public typealias MovieReviewsResponse = PagedResponse<ReviewResponse>

public struct ReviewResponse: Codable, Equatable {
    public var author: String?
    public var authorDetails: AuthorDetails?
    public var content: String?
    public var createdAt: String?
    public var id: String
    public var updatedAt: String?
    public var url: String?

    enum CodingKeys: String, CodingKey {
        case author
        case authorDetails = "author_details"
        case content
        case createdAt = "created_at"
        case id
        case updatedAt = "updated_at"
        case url
    }
}
