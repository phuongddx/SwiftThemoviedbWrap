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

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.author = try container.decodeIfPresent(String.self, forKey: .author)
        self.authorDetails = try container.decodeIfPresent(AuthorDetails.self, forKey: .authorDetails)
        self.content = try container.decodeIfPresent(String.self, forKey: .content)
        self.createdAt = try container.decodeIfPresent(String.self, forKey: .createdAt)
        self.id = try container.decode(String.self, forKey: .id)
        self.updatedAt = try container.decodeIfPresent(String.self, forKey: .updatedAt)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
    }
}
