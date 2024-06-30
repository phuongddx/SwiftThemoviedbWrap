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

    var sut: MoviesTarget!

    func test_getTodayTrendingList() throws {
        sut = MoviesTarget.trending(
            type: .today,
            request: MockRequestable.pageQuery)

        XCTAssertEqual(sut.queryParamsEncoding, .default)
        XCTAssertEqual(sut.path, "/trending/movie/today")
        XCTAssertEqual(sut.queryParams, ["page": "1", "api_key": "key", "language": "en-US"])
        XCTAssertEqual(sut.baseURL.rawValue, URL(string: "https://api.themoviedb.org/3")!)
    }

    func test_getMovieRecommendationList() {
        sut = MoviesTarget.getMovieList(
            ofType: .recommendations,
            request: MockRequestable.movieRecommendations)

        XCTAssertEqual(sut.queryParamsEncoding, .default)
        XCTAssertEqual(sut.path, "/movie/1234/recommendations")
        XCTAssertEqual(sut.queryParams, ["page": "2", "language": "en-US", "api_key": "key"])
        XCTAssertEqual(sut.baseURL.rawValue, URL(string: "https://api.themoviedb.org/3")!)
    }
}

extension URL {
    func queryParameters() -> [URLQueryItem] {
        URLComponents(url: self.absoluteURL, resolvingAgainstBaseURL: false)?.queryItems ?? []
    }
}

extension XCTestCase {
    func assertEqualURLs(_ url1: URL,
                         _ url2: URL,
                         file: StaticString = #file,
                         line: UInt = #line) {
        XCTAssertEqual(url1.scheme, url2.scheme, "URL schemes are not equal", file: file, line: line)
        XCTAssertEqual(url1.host, url2.host, "URL hosts are not equal", file: file, line: line)
        XCTAssertEqual(url1.path, url2.path, "URL paths are not equal", file: file, line: line)
        
        let params1 = Set(url1.queryParameters())
        let params2 = Set(url2.queryParameters())
        XCTAssertEqual(params1, params2, "URL query parameters are not equal", file: file, line: line)
    }
}
