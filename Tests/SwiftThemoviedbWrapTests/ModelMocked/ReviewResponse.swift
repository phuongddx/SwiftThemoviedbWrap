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

extension MovieReviewsResponse {
    static var mock: PagedResponse<ReviewResponse> {
        let data = reviewsJSON.data(using: .utf16)!
        return try! JSONDecoder().decode(PagedResponse<ReviewResponse>.self, from: data)
    }
}

let search_personJSON: String =
"""
{
  "page": 1,
  "results": [
    {
      "adult": false,
      "gender": 2,
      "id": 500,
      "known_for_department": "Acting",
      "name": "Tom Cruise",
      "original_name": "Tom Cruise",
      "popularity": 85.911,
      "profile_path": "/eOh4ubpOm2Igdg0QH2ghj0mFtC.jpg",
      "known_for": [
        {
          "backdrop_path": "/4V1yIoAKPMRQwGBaSses8Bp2nsi.jpg",
          "id": 137113,
          "original_title": "Edge of Tomorrow",
          "overview": "Major Bill Cage is an officer who has never seen a day of combat when he is unceremoniously demoted and dropped into combat. Cage is killed within minutes, managing to take an alpha alien down with him. He awakens back at the beginning of the same day and is forced to fight and die again... and again - as physical contact with the alien has thrown him into a time loop.",
          "poster_path": "/xjw5trHV7Mwo61P0kCTy8paEkgO.jpg",
          "media_type": "movie",
          "adult": false,
          "title": "Edge of Tomorrow",
          "original_language": "en",
          "genre_ids": [
            28,
            878
          ],
          "popularity": 67.05,
          "release_date": "2014-05-27",
          "video": false,
          "vote_average": 7.618,
          "vote_count": 13443
        },
        {
          "backdrop_path": "/A6wFgFFEgymebp518fcsa71jnSu.jpg",
          "id": 75612,
          "original_title": "Oblivion",
          "overview": "Jack Harper is one of the last few drone repairmen stationed on Earth. Part of a massive operation to extract vital resources after decades of war with a terrifying threat known as the Scavs, Jack’s mission is nearly complete. His existence is brought crashing down when he rescues a beautiful  stranger from a downed spacecraft. Her arrival triggers a chain of events that  forces him to question everything he knows and puts the fate of humanity in his hands.",
          "poster_path": "/eO3r38fwnhb58M1YgcjQBd3VNcp.jpg",
          "media_type": "movie",
          "adult": false,
          "title": "Oblivion",
          "original_language": "en",
          "genre_ids": [
            28,
            878,
            12,
            9648
          ],
          "popularity": 42.191,
          "release_date": "2013-04-10",
          "video": false,
          "vote_average": 6.638,
          "vote_count": 10427
        },
        {
          "backdrop_path": "/ih4lZkUpmSE7AP3maymiO72xJ1z.jpg",
          "id": 56292,
          "original_title": "Mission: Impossible - Ghost Protocol",
          "overview": "Ethan Hunt and his team are racing against time to track down a dangerous terrorist named Hendricks, who has gained access to Russian nuclear launch codes and is planning a strike on the United States. An attempt to stop him ends in an explosion causing severe destruction to the Kremlin and the IMF to be implicated in the bombing, forcing the President to disavow them. No longer being aided by the government, Ethan and his team chase Hendricks around the globe, although they might still be too late to stop a disaster.",
          "poster_path": "/7GCKNRbzcA4rJXAKoE8KS9IDnZP.jpg",
          "media_type": "movie",
          "adult": false,
          "title": "Mission: Impossible - Ghost Protocol",
          "original_language": "en",
          "genre_ids": [
            28,
            53,
            12
          ],
          "popularity": 68.707,
          "release_date": "2011-12-07",
          "video": false,
          "vote_average": 7.083,
          "vote_count": 9637
        }
      ]
    },
    {
      "adult": false,
      "gender": 2,
      "id": 31,
      "known_for_department": "Acting",
      "name": "Tom Hanks",
      "original_name": "Tom Hanks",
      "popularity": 86.857,
      "profile_path": "/eKF1sGJRrZJbfBG1KirPt1cfNd3.jpg",
      "known_for": [
        {
          "backdrop_path": "/mzfx54nfDPTUXZOG48u4LaEheDy.jpg",
          "id": 13,
          "original_title": "Forrest Gump",
          "overview": "A man with a low IQ has accomplished great things in his life and been present during significant historic events—in each case, far exceeding what anyone imagined he could do. But despite all he has achieved, his one true love eludes him.",
          "poster_path": "/arw2vcBveWOVZr6pxd9XTd1TdQa.jpg",
          "media_type": "movie",
          "adult": false,
          "title": "Forrest Gump",
          "original_language": "en",
          "genre_ids": [
            35,
            18,
            10749
          ],
          "popularity": 159.372,
          "release_date": "1994-06-23",
          "video": false,
          "vote_average": 8.475,
          "vote_count": 26787
        },
        {
          "backdrop_path": "/lxD5ak7BOoinRNehOCA85CQ8ubr.jpg",
          "id": 862,
          "original_title": "Toy Story",
          "overview": "Led by Woody, Andy's toys live happily in his room until Andy's birthday brings Buzz Lightyear onto the scene. Afraid of losing his place in Andy's heart, Woody plots against Buzz. But when circumstances separate Buzz and Woody from their owner, the duo eventually learns to put aside their differences.",
          "poster_path": "/uXDfjJbdP4ijW5hWSBrPrlKpxab.jpg",
          "media_type": "movie",
          "adult": false,
          "title": "Toy Story",
          "original_language": "en",
          "genre_ids": [
            16,
            12,
            10751,
            35
          ],
          "popularity": 160.833,
          "release_date": "1995-10-30",
          "video": false,
          "vote_average": 7.972,
          "vote_count": 17970
        },
        {
          "backdrop_path": "/vxJ08SvwomfKbpboCWynC3uqUg4.jpg",
          "id": 497,
          "original_title": "The Green Mile",
          "overview": "A supernatural tale set on death row in a Southern prison, where gentle giant John Coffey possesses the mysterious power to heal people's ailments. When the cell block's head guard, Paul Edgecomb, recognizes Coffey's miraculous gift, he tries desperately to help stave off the condemned man's execution.",
          "poster_path": "/8VG8fDNiy50H4FedGwdSVUPoaJe.jpg",
          "media_type": "movie",
          "adult": false,
          "title": "The Green Mile",
          "original_language": "en",
          "genre_ids": [
            14,
            18,
            80
          ],
          "popularity": 100.444,
          "release_date": "1999-12-10",
          "video": false,
          "vote_average": 8.505,
          "vote_count": 16920
        }
      ]
    },
    {
      "adult": false,
      "gender": 2,
      "id": 10993,
      "known_for_department": "Acting",
      "name": "Tom Felton",
      "original_name": "Tom Felton",
      "popularity": 32.233,
      "profile_path": "/etmtUBzJ1i1XJTLS6MkotJFE1se.jpg",
      "known_for": [
        {
          "backdrop_path": "/hziiv14OpD73u9gAak4XDDfBKa2.jpg",
          "id": 671,
          "original_title": "Harry Potter and the Philosopher's Stone",
          "overview": "Harry Potter has lived under the stairs at his aunt and uncle's house his whole life. But on his 11th birthday, he learns he's a powerful wizard—with a place waiting for him at the Hogwarts School of Witchcraft and Wizardry. As he learns to harness his newfound powers with the help of the school's kindly headmaster, Harry uncovers the truth about his parents' deaths—and about the villain who's to blame.",
          "poster_path": "/wuMc08IPKEatf9rnMNXvIDxqP4W.jpg",
          "media_type": "movie",
          "adult": false,
          "title": "Harry Potter and the Philosopher's Stone",
          "original_language": "en",
          "genre_ids": [
            12,
            14
          ],
          "popularity": 189.028,
          "release_date": "2001-11-16",
          "video": false,
          "vote_average": 7.913,
          "vote_count": 26688
        },
        {
          "backdrop_path": "/r5xT55Era1XrpAq6XNsrPpozNjM.jpg",
          "id": 767,
          "original_title": "Harry Potter and the Half-Blood Prince",
          "overview": "As Lord Voldemort tightens his grip on both the Muggle and wizarding worlds, Hogwarts is no longer a safe haven. Harry suspects perils may even lie within the castle, but Dumbledore is more intent upon preparing him for the final battle fast approaching. Together they work to find the key to unlock Voldemorts defenses and to this end, Dumbledore recruits his old friend and colleague Horace Slughorn, whom he believes holds crucial information. Even as the decisive showdown looms, romance blossoms for Harry, Ron, Hermione and their classmates. Love is in the air, but danger lies ahead and Hogwarts may never be the same again.",
          "poster_path": "/z7uo9zmQdQwU5ZJHFpv2Upl30i1.jpg",
          "media_type": "movie",
          "adult": false,
          "title": "Harry Potter and the Half-Blood Prince",
          "original_language": "en",
          "genre_ids": [
            12,
            14
          ],
          "popularity": 140.616,
          "release_date": "2009-07-15",
          "video": false,
          "vote_average": 7.693,
          "vote_count": 18954
        },
        {
          "backdrop_path": "/1stUIsjawROZxjiCMtqqXqgfZWC.jpg",
          "id": 672,
          "original_title": "Harry Potter and the Chamber of Secrets",
          "overview": "Cars fly, trees fight back, and a mysterious house-elf comes to warn Harry Potter at the start of his second year at Hogwarts. Adventure and danger await when bloody writing on a wall announces: The Chamber Of Secrets Has Been Opened. To save Hogwarts will require all of Harry, Ron and Hermione’s magical abilities and courage.",
          "poster_path": "/sdEOH0992YZ0QSxgXNIGLq1ToUi.jpg",
          "media_type": "movie",
          "adult": false,
          "title": "Harry Potter and the Chamber of Secrets",
          "original_language": "en",
          "genre_ids": [
            12,
            14
          ],
          "popularity": 144.321,
          "release_date": "2002-11-13",
          "video": false,
          "vote_average": 7.721,
          "vote_count": 21418
        }
      ]
    }
  ],
  "total_pages": 500,
  "total_results": 10000
}
"""

extension PersonPagedResponse {
    static var mock: PersonPagedResponse {
        try! JSONDecoder().decode(PersonPagedResponse.self, from: search_personJSON.data(using: .utf8)!)
    }
}
