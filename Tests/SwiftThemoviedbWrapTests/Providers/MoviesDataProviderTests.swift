//
//  MoviesDataProviderTests.swift
//
//
//  Created by PhuongDoan on 21/6/24.
//

import Foundation
import SwiftNetworkWrap
import XCTest
import Combine
@testable import SwiftThemoviedbWrap

final class MoviesDataProviderTests: XCTestCase {

    private var subscriptions: Set<AnyCancellable> = Set<AnyCancellable>()
    var sut: MoviesDataProvider!

    override func setUp() {
        createMockConfig()
        sut = DefaultMoviesDataProvider(urlSession: .mock)
    }

    override func tearDown() {
        //        Mocker.removeAll()
        super.tearDown()
    }

    func test_getTodayTrendingList_shouldReturnAnList() throws {
        MockingURLSession.resgister(MockedData.moviesListJSON.data)
        let expectation = expectation(description: "an movies list should come")

        sut.getTrendingList(type: .today,
                            request: DefaultMoviesRequest(page: 2))
            .sinkToResult { result in
                switch result {
                case .success(let moviesDTO):
                    XCTAssertTrue(!moviesDTO.results.isEmpty)
                    XCTAssertEqual(moviesDTO.results.first!.title, "Scream VI")
                    expectation.fulfill()
                case .failure(let error):
                    XCTFail("should not reach here, Error: \(error.localizedDescription)")
                }
            }
            .store(in: &subscriptions)

        wait(for: [expectation], timeout: 5)
    }

    func test_getTodayTrendingList_shouldFailure() throws {
        MockingURLSession.resgister400ErrorCode()
        let expectation = expectation(description: "an failure error come")

        sut.getTrendingList(type: .today,
                            request: DefaultMoviesRequest(page: 2))
            .sinkToResult { result in
                switch result {
                case .failure:
                    expectation.fulfill()
                default:
                    XCTFail("should not reach here")
                }
            }
            .store(in: &subscriptions)

        wait(for: [expectation], timeout: 2)
    }

    func test_getMoviveReviews_shouldSuccess() throws {
        MockingURLSession.resgister(MockedData.reviewListJSON.data)
        let expectation = expectation(description: "should return an review list")

        sut.getMovieReviewList(request: MovieReviewsRequest(movieId: 123, page: 2))
            .sinkToResult {
                switch $0 {
                case .success(let reviewPaged):
                    XCTAssertFalse(reviewPaged.results.isEmpty)
                    XCTAssertEqual(reviewPaged.results.first!.author, "elshaarawy")
                    expectation.fulfill()
                case .failure(let error):
                    XCTFail("should not reach here, Error: \(error.localizedDescription)")
                }
            }
            .store(in: &subscriptions)

        wait(for: [expectation], timeout: 5)
    }
}

extension MoviesResponse {
    static var mocked: MoviesResponse {
        MoviesResponse(page: 1,
                       totalPages: 10,
                       results: [Movie.mockMovie1, Movie.mockMovie2])
    }
}

extension Movie {
    static var mockMovie1 = Movie(
        id: 1,
        title: "Mock Movie 1",
        originalTitle: "Mock Original Title 1",
        overview: "This is a brief overview of Mock Movie 1.",
        posterPath: "/mockPoster1.jpg",
        backdropPath: "/mockBackdrop1.jpg",
        mediaType: "movie",
        adult: false,
        originalLanguage: "en",
        genreIds: [28, 12],
        popularity: 10.5,
        releaseDate: "2022-01-01",
        video: false,
        voteAverage: 7.8,
        voteCount: 1234
    )

    static var mockMovie2 = Movie(
        id: 2,
        title: "Mock Movie 2",
        originalTitle: "Mock Original Title 2",
        overview: "This is a brief overview of Mock Movie 2.",
        posterPath: "/mockPoster2.jpg",
        backdropPath: "/mockBackdrop2.jpg",
        mediaType: "movie",
        adult: false,
        originalLanguage: "fr",
        genreIds: [35, 18],
        popularity: 20.3,
        releaseDate: "2023-02-02",
        video: false,
        voteAverage: 8.2,
        voteCount: 5678
    )

}


extension URL {
    var data: Data {
        try! Data(contentsOf: self)
    }
}
