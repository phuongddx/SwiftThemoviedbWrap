//
//  MovieDetailsTests.swift
//
//
//  Created by PhuongDoan on 24/6/24.
//

import Foundation
import XCTest
@testable import SwiftThemoviedbWrap

final class MovieDetailsTests: XCTestCase {
    func test_DecodingShouldSuccess() throws {
        let actual = MovieDetailResponse.mock
        
        XCTAssertEqual(actual.backdropPath, "/620hnMVLu6RSZW6a5rwO8gqpt0t.jpg")
        XCTAssertNotNil(actual.credits)
        XCTAssertNotNil(actual.recommendations)
        XCTAssertNotNil(actual.videos)
    }
}
