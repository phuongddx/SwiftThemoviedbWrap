//
//  MovieDetailResponse.swift
//
//
//  Created by PhuongDoan on 24/6/24.
//

import Foundation
@testable import SwiftThemoviedbWrap

let movie_details: String = 
"""
{
  "adult": false,
  "backdrop_path": "/620hnMVLu6RSZW6a5rwO8gqpt0t.jpg",
  "belongs_to_collection": null,
  "budget": 200000000,
  "genres": [
    {
      "id": 16,
      "name": "Animation"
    },
    {
      "id": 35,
      "name": "Comedy"
    },
    {
      "id": 14,
      "name": "Fantasy"
    },
    {
      "id": 12,
      "name": "Adventure"
    },
    {
      "id": 10751,
      "name": "Family"
    }
  ],
  "homepage": "https://www.disneyplus.com/movies/luca/7K1HyQ6Hl16P",
  "id": 508943,
  "imdb_id": "tt12801262",
  "origin_country": [
    "US"
  ],
  "original_language": "en",
  "original_title": "Luca",
  "overview": "Luca and his best friend Alberto experience an unforgettable summer on the Italian Riviera. But all the fun is threatened by a deeply-held secret: they are sea monsters from another world just below the water’s surface.",
  "popularity": 104.752,
  "poster_path": "/jTswp6KyDYKtvC52GbHagrZbGvD.jpg",
  "production_companies": [
    {
      "id": 3,
      "logo_path": "/1TjvGVDMYsj6JBxOAkUHpPEwLf7.png",
      "name": "Pixar",
      "origin_country": "US"
    },
    {
      "id": 2,
      "logo_path": "/wdrCwmRnLFJhEoH8GSfymY85KHT.png",
      "name": "Walt Disney Pictures",
      "origin_country": "US"
    }
  ],
  "production_countries": [
    {
      "iso_3166_1": "US",
      "name": "United States of America"
    }
  ],
  "release_date": "2021-06-17",
  "revenue": 51074773,
  "runtime": 95,
  "spoken_languages": [
    {
      "english_name": "English",
      "iso_639_1": "en",
      "name": "English"
    },
    {
      "english_name": "Italian",
      "iso_639_1": "it",
      "name": "Italiano"
    }
  ],
  "status": "Released",
  "tagline": "Prepare for an unforgettable trip.",
  "title": "Luca",
  "video": false,
  "vote_average": 7.8,
  "vote_count": 8126,
  "videos": {
    "results": [
      {
        "iso_639_1": "en",
        "iso_3166_1": "US",
        "name": "‘Luca’ Director Enrico Casarosa Breaks Down a Scene | 94th Oscars",
        "key": "ooo-X7I9G1o",
        "site": "YouTube",
        "size": 1080,
        "type": "Featurette",
        "official": true,
        "published_at": "2022-03-23T19:00:11.000Z",
        "id": "63e3b8f2db154f007c38152f"
      },
      {
        "iso_639_1": "en",
        "iso_3166_1": "US",
        "name": "BFI At Home | Looking at Luca: Pixar’s nod to Fellini and Ghibli",
        "key": "fonzyI31-iE",
        "site": "YouTube",
        "size": 1080,
        "type": "Featurette",
        "official": true,
        "published_at": "2021-06-17T18:00:12.000Z",
        "id": "63284a45124c8d007a791692"
      }
    ]
  },
  "credits": {
    "cast": [
      {
        "adult": false,
        "gender": 2,
        "id": 1277188,
        "known_for_department": "Acting",
        "name": "Jacob Tremblay",
        "original_name": "Jacob Tremblay",
        "popularity": 30.039,
        "profile_path": "/h8CXDp86Y36CUENF4SXJq5ZRTsf.jpg",
        "cast_id": 9,
        "character": "Luca Paguro (voice)",
        "credit_id": "6037b03e11c0660040492809",
        "order": 0
      },
      {
        "adult": false,
        "gender": 2,
        "id": 1774679,
        "known_for_department": "Acting",
        "name": "Jack Dylan Grazer",
        "original_name": "Jack Dylan Grazer",
        "popularity": 15.155,
        "profile_path": "/cZdGLa78UP7VzMgNbDRnoaSkZm1.jpg",
        "cast_id": 10,
        "character": "Alberto Scorfano (voice)",
        "credit_id": "6037b081b76cbb0040cc2c8f",
        "order": 1
      }
    ],
    "crew": [
      {
        "adult": false,
        "gender": 2,
        "id": 930567,
        "known_for_department": "Directing",
        "name": "Enrico Casarosa",
        "original_name": "Enrico Casarosa",
        "popularity": 2.897,
        "profile_path": "/3UzBWIqYw0T0aLkdp6oEyLzWOE0.jpg",
        "credit_id": "5f22cfa53503980033e31828",
        "department": "Directing",
        "job": "Director"
      },
      {
        "adult": false,
        "gender": 0,
        "id": 7972,
        "known_for_department": "Production",
        "name": "Andrea Warren",
        "original_name": "Andrea Warren",
        "popularity": 2.675,
        "profile_path": null,
        "credit_id": "5f22cfafeea34d003735f9fe",
        "department": "Production",
        "job": "Producer"
      },
      {
        "adult": false,
        "gender": 2,
        "id": 12890,
        "known_for_department": "Directing",
        "name": "Pete Docter",
        "original_name": "Pete Docter",
        "popularity": 34.773,
        "profile_path": "/xz46mHzo8apkVMxmrkMQvqakOL0.jpg",
        "credit_id": "5f7f9fdbd861af00368755b2",
        "department": "Production",
        "job": "Executive Producer"
      }
    ]
  },
  "reviews": {
    "page": 1,
    "results": [
      {
        "author": "garethmb",
        "author_details": {
          "name": "test nameasd",
          "username": "garethmb",
          "avatar_path": "null",
          "rating": 0
        },
        "content": "Th comes up lacking out of 5",
        "created_at": "2021-06-16T16:08:48.678Z",
        "id": "60ca22102fccee003fb40e51",
        "updated_at": "2021-06-23T15:58:56.937Z",
        "url": "https://www.themoviedb.org/review/60ca22102fccee003fb40e51"
      }
    ],
    "total_pages": 1,
    "total_results": 5
  },
  "recommendations": {
    "page": 1,
    "results": [
      {
        "backdrop_path": "/rcUcYzGGicDvhDs58uM44tJKB9F.jpg",
        "id": 527774,
        "original_title": "Raya and the Last Dragon",
        "overview": "Long ago, in the fantasy world of Kumandra, humans and dragons lived together in harmony. But when an evil force threatened the land, the dragons sacrificed themselves to save humanity. Now, 500 years later, that same evil has returned and it’s up to a lone warrior, Raya, to track down the legendary last dragon to restore the fractured land and its divided people.",
        "poster_path": "/lPsD10PP4rgUGiGR4CCXA6iY0QQ.jpg",
        "media_type": "movie",
        "adult": false,
        "title": "Raya and the Last Dragon",
        "original_language": "en",
        "genre_ids": [
          16,
          10751,
          14,
          28,
          12
        ],
        "popularity": 105.283,
        "release_date": "2021-03-03",
        "video": false,
        "vote_average": 7.9,
        "vote_count": 6604
      },
      {
        "backdrop_path": "/4kIRrW1AlHP5Idne8CPHeQt8nR5.jpg",
        "id": 550205,
        "original_title": "Wish Dragon",
        "overview": "Determined teen Din is longing to reconnect with his childhood best friend when he meets a wish-granting dragon who shows him the magic of possibilities.",
        "poster_path": "/lnPf6hzANL6pVQTxUlsNYSuhT5l.jpg",
        "media_type": "movie",
        "adult": false,
        "title": "Wish Dragon",
        "original_language": "en",
        "genre_ids": [
          16,
          10751,
          35,
          14
        ],
        "popularity": 52.758,
        "release_date": "2021-01-15",
        "video": false,
        "vote_average": 7.9,
        "vote_count": 1277
      }
    ],
    "total_pages": 2,
    "total_results": 40
  }
}
"""


extension MovieDetailResponse {
    static var mock: MovieDetailResponse {
        decode(movie_details)!
    }
}

func decode<T: Codable & Equatable>(_ jsonString: String) -> T? {
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: jsonString.data(using: .utf8)!)
    } catch let error as DecodingError {
        switch error {
        case .dataCorrupted(let context):
            print("Data corrupted: \(context.debugDescription)")
        case .keyNotFound(let key, let context):
            print("Key '\(key)' not found: \(context.debugDescription)")
        case .typeMismatch(let type, let context):
            print("Type mismatch for type \(type): \(context.debugDescription)")
        case .valueNotFound(let type, let context):
            print("Value not found for type \(type): \(context.debugDescription)")
        @unknown default:
            print("Unknown decoding error: \(error)")
        }
    } catch {
        print("Other error: \(error)")
    }
    return nil
}
