//
//  File.swift
//  
//
//  Created by PhuongDoan on 23/6/24.
//

import Foundation
@testable import SwiftThemoviedbWrap

let reviewsJSON: String =
    """
    {
      "id": 550,
      "page": 1,
      "results": [
        {
          "author": "katch22",
          "author_details": {
            "name": "",
            "username": "katch22",
            "avatar_path": null,
            "rating": 8
          },
          "content": "Madness unbounded.  Don't try to make sense of insanity, just ride a wild ride.",
          "created_at": "2021-07-13T18:37:57.161Z",
          "id": "60eddd855f622b005e51f938",
          "updated_at": "2021-07-14T13:17:01.343Z",
          "url": "https://www.themoviedb.org/review/60eddd855f622b005e51f938"
        },
        {
          "author": "alksjalksj",
          "author_details": {
            "name": "",
            "username": "alksjalksj",
            "avatar_path": "/vYtiI5wiy8iX7BaLbanPCHaNPUs.jpg",
            "rating": 10
          },
          "content": "The best movie i've seen, also my head hurts",
          "created_at": "2022-12-11T06:20:22.180Z",
          "id": "639576a62cefc200a2fd4f33",
          "updated_at": "2022-12-13T20:53:10.226Z",
          "url": "https://www.themoviedb.org/review/639576a62cefc200a2fd4f33"
        }
      ],
      "total_pages": 1,
      "total_results": 8
    }
    """

extension MovieReviewsResponseDTO {
    static var mock: PagedResponse<ReviewDTO> {
        let data = reviewsJSON.data(using: .utf16)!
        return try! JSONDecoder().decode(PagedResponse<ReviewDTO>.self, from: data)
    }
}
