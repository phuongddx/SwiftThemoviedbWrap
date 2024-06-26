//
//  MoviesDataProvider.swift
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
    typealias Mock = RequestMocking.MockedResponse

    private var subscriptions: Set<AnyCancellable> = Set<AnyCancellable>()
    var sut: MoviesDataProvider!
    var mockNetworkWrap: MockTmdbNetworkWrapProvider!

    override func setUp() {
        createMockConfig()
        mockNetworkWrap = MockTmdbNetworkWrapProvider()
        sut = DefaultMoviesDataProvider(provider: mockNetworkWrap)
    }

    override func tearDown() {
        RequestMocking.removeAllMocks()
    }

    func test_getTodayTrendingList_shouldReturnAnList() throws {
        let target = MoviesTarget.todayTrending(request: DefaultMoviesRequest(page: 2))
        try mock(target, result: .success(MoviesResponse.mocked))
        let expectation = expectation(description: "an movies list should come")

        sut.getTrendingList(type: .today,
                            request: DefaultMoviesRequest(page: 2))
            .sinkToResult { result in
                switch result {
                case .success(let moviesDTO):
                    XCTAssertTrue(!moviesDTO.results.isEmpty)
                    XCTAssertEqual(moviesDTO.results.first!.title, "Mock Movie 1")
                    expectation.fulfill()
                case .failure(let error):
                    if let error = error as? TmdbApiError {
                        print("xxxxx")
                    }
                    XCTFail("should not reach here, Error: \(error.localizedDescription)")
                }
            }
            .store(in: &subscriptions)

        wait(for: [expectation], timeout: 3)
    }

    func test_getTodayTrendingList_shouldFailure() throws {
        let requestDTO = DefaultMoviesRequest(page: 2)
        let mockFailure = Mock(url: URL(string: "https://testing.com")!,
                               result: .failure(ApiError.unexpectedResponse))
        RequestMocking.add(mock: mockFailure)
        let expectation = expectation(description: "an failure error come")

        sut.getTrendingList(type: .today,
                            request: requestDTO)
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
        let requestDto = MovieReviewsRequest(movieId: 123, page: 2)
        try self.mock(MoviesTarget.reviews(request: requestDto),
                      result: .success(MovieReviewsResponse.mock))

        let expectation = expectation(description: "should return an review list")

        sut.getMovieReviewList(request: requestDto)
            .sinkToResult {
                switch $0 {
                case .success(let reviewPaged):
                    XCTAssertFalse(reviewPaged.results.isEmpty)
                    XCTAssertEqual(reviewPaged.results.first?.author, "katch22")
                    expectation.fulfill()
                default:
                    XCTFail("should not reach here")
                }
            }
            .store(in: &subscriptions)

        wait(for: [expectation], timeout: 4)
    }

    private func mock<T>(_ target: TmdbApiTarget,
                         baseURL: String = "https://testing.com",
                         result: Result<T, Swift.Error>,
                         httpCode: HTTPCode = 200) throws where T: Encodable {
        let mock = try Mock(target: target,
                            baseURL: baseURL,
                            result: result,
                            httpCode: httpCode)
        RequestMocking.add(mock: mock)
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
