//
//  MoviesTargetTests.swift
//  
//
//  Created by PhuongDoan on 22/6/24.
//

import XCTest
@testable import SwiftThemoviedbWrap

final class MoviesTargetTests: XCTestCase {

    func test_getMovieDetail() throws {
        let request = MovieDetailRequest(
            movieId: 1234,
            additionalResponse: ["videos", "credits"])
        let sut = MoviesTarget.detail(request: request, tmdbConfig: .mock)
    
        let urlRequest = try sut.urlRequest(baseURL: "https://test.com")
        let actualURL: String = urlRequest.url!.absoluteString
        let expectedURL: String = "https://test.com/movie/1234?append_to_response=videos,credits"

        XCTAssertEqual(actualURL, expectedURL)
        XCTAssertEqual(sut.path, "/movie/1234")
        XCTAssertEqual(sut.method, "GET")
    }

    func test_getTodayTrendingList() throws {
        let request = DefaultMoviesRequest(page: 2)
        let sut = MoviesTarget.todayTrending(request: request, tmdbConfig: .mock)

        let urlRequest = try sut.urlRequest(baseURL: "https://test.com")
        let actualURL: String = urlRequest.url!.absoluteString
        let expectedURL: String = "https://test.com/trending/movie/day?page=2"

        XCTAssertEqual(sut.path, "/trending/movie/day")
        XCTAssertEqual(expectedURL, actualURL)
    }

    func test_getWeekTrendingList() throws {
        let request = DefaultMoviesRequest(page: 2)
        let sut = MoviesTarget.weekTrending(request: request, tmdbConfig: .mock)

        let urlRequest = try sut.urlRequest(baseURL: "https://test.com")
        let actualURL: String = urlRequest.url!.absoluteString
        let expectedURL: String = "https://test.com/trending/movie/week?page=2"

        XCTAssertEqual(sut.path, "/trending/movie/week")
        XCTAssertEqual(expectedURL, actualURL)
    }

    func test_getMovieReviews() throws {
        let request = MovieReviewsRequest(movieId: 111, page: 2)
        let sut = MoviesTarget.reviews(request: request, tmdbConfig: .mock)

        let urlRequest = try sut.urlRequest(baseURL: "https://test.com")
        let actualURL = urlRequest.url?.absoluteURL
        let expectedURL = URL(string: "https://test.com/movie/111/reviews?page=2")
        XCTAssertEqual(actualURL, expectedURL)
        XCTAssertEqual(sut.path, "/movie/111/reviews")
    }
}
