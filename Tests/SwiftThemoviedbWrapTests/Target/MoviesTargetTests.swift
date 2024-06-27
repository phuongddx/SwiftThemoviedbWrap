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
        createMockConfig()
    }
    
    func test_getMovieDetail() throws {
        let request = MovieDetailRequest(
            movieId: 1234,
            additionalResponse: ["videos", "credits"])
        let sut = MoviesTarget.detail(request: request)
        
        let urlRequest = try sut.buildURLRequest()
        let actualURL: URL = urlRequest.url!.absoluteURL
        let expectedURL = URL(string: "https://api.themoviedb.org/movie/1234?append_to_response=videos,credits&api_key=key&language=en-US")!
        assertEqualURLs(actualURL, expectedURL)
    }
    
    func test_getTodayTrendingList() throws {
        let request = DefaultMoviesRequest(page: 2)
        let sut = MoviesTarget.todayTrending(request: request)
        
        let urlRequest = try sut.buildURLRequest()
        let actualURL: URL = urlRequest.url!.absoluteURL
        let expectedURL: URL = URL(string: "https://api.themoviedb.org/trending/movie/day?page=2&api_key=key&language=en-US")!
        
        assertEqualURLs(actualURL, expectedURL)
    }
    
    func test_getWeekTrendingList() throws {
        let request = DefaultMoviesRequest(page: 2)
        let sut = MoviesTarget.weekTrending(request: request)
        
        let urlRequest = try sut.buildURLRequest()
        let actualURL: URL = urlRequest.url!.absoluteURL
        let expectedURL: URL = URL(string: "https://api.themoviedb.org/trending/movie/week?page=2&api_key=key&language=en-US")!

        assertEqualURLs(actualURL, expectedURL)
    }
    
    func test_getMovieReviews() throws {
        let request = MovieReviewsRequest(movieId: 111, page: 2)
        let sut = MoviesTarget.reviews(request: request)
        
        let urlRequest = try sut.buildURLRequest()
        guard let actualURL = urlRequest.url?.absoluteURL else {
            XCTFail("URL request is nil")
            return
        }
        let expectedURL = URL(string: "https://api.themoviedb.org/movie/111/reviews?page=2&api_key=key&language=en-US")!

        assertEqualURLs(actualURL, expectedURL)
    }
}

extension URL {
    func queryParameters() -> [URLQueryItem] {
        URLComponents(url: self.absoluteURL, resolvingAgainstBaseURL: false)?.queryItems ?? []
    }
}

extension XCTestCase {
    func assertEqualURLs(_ url1: URL, _ url2: URL, file: StaticString = #file, line: UInt = #line) {
        XCTAssertEqual(url1.scheme, url2.scheme, "URL schemes are not equal", file: file, line: line)
        XCTAssertEqual(url1.host, url2.host, "URL hosts are not equal", file: file, line: line)
        XCTAssertEqual(url1.path, url2.path, "URL paths are not equal", file: file, line: line)

        let params1 = Set(url1.queryParameters())
        let params2 = Set(url2.queryParameters())
        XCTAssertEqual(params1, params2, "URL query parameters are not equal", file: file, line: line)
    }
}
