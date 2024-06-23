//
//  MoviesTargetTests.swift
//  
//
//  Created by PhuongDoan on 22/6/24.
//

import XCTest
@testable import SwiftThemoviedbWrap

final class MoviesTargetTests: XCTestCase {
    override func setUp() {
        TMDBConfigurationManager.shared = MockTMDBConfigurationManager()
    }

    func test_getMovieDetail() throws {
        let requestDto = MovieDetailRequestDTO(
            movieId: 1234,
            additionalResponse: ["videos", "credits"])
        let sut = MoviesTarget.detail(request: requestDto)
    
        let urlRequest = try sut.urlRequest(baseURL: "https://test.com")
        let actualURL: String = urlRequest.url!.absoluteString
        let expectedURL: String = "https://test.com/movie/1234?append_to_response=videos,credits"

        XCTAssertEqual(actualURL, expectedURL)
        XCTAssertEqual(sut.path, "/movie/1234")
        XCTAssertEqual(sut.method, "GET")
    }

    func test_getTodayTrendingList() throws {
        let requestDto = DefaultMoviesRequestDTO(page: 2)
        let sut = MoviesTarget.todayTrending(request: requestDto)

        let urlRequest = try sut.urlRequest(baseURL: "https://test.com")
        let actualURL: String = urlRequest.url!.absoluteString
        let expectedURL: String = "https://test.com/trending/movie/day?page=2"

        XCTAssertEqual(sut.path, "/trending/movie/day")
        XCTAssertEqual(expectedURL, actualURL)
    }

    func test_getWeekTrendingList() throws {
        let requestDto = DefaultMoviesRequestDTO(page: 2)
        let sut = MoviesTarget.weekTrending(request: requestDto)

        let urlRequest = try sut.urlRequest(baseURL: "https://test.com")
        let actualURL: String = urlRequest.url!.absoluteString
        let expectedURL: String = "https://test.com/trending/movie/week?page=2"

        XCTAssertEqual(sut.path, "/trending/movie/week")
        XCTAssertEqual(expectedURL, actualURL)
    }

    func test_getMovieReviews() throws {
        let requestDto = MovieReviewsRequestDTO(movieId: 111, page: 2)
        let sut = MoviesTarget.reviews(request: requestDto)

        let urlRequest = try sut.urlRequest(baseURL: "https://test.com")
        let actualURL = urlRequest.url?.absoluteURL
        let expectedURL = URL(string: "https://test.com/movie/111/reviews?page=2")
        XCTAssertEqual(actualURL, expectedURL)
        XCTAssertEqual(sut.path, "/movie/111/reviews")
    }
}
