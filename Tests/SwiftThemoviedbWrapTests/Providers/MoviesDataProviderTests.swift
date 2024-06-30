//
//  MoviesDataProviderTests.swift
//
//
//  Created by PhuongDoan on 21/6/24.
//

import SwiftNetworkWrap
import XCTest
import Combine
@testable import SwiftThemoviedbWrap

final class MockNetworkClient: TmdbNetworkClientManager {
    override init(clientURLSession: any NetworkClient = DefaultNetworkClient(session: .mock)) {
        super.init(clientURLSession: clientURLSession)
    }
}

struct MockRequestable {
    private init() {}

    static var pageQuery: MoviesRequestable {
        DefaultMoviesRequest()
    }

    static var movieReviewQuery: MovieReviewsRequest {
        MovieReviewsRequest(movieId: 1234, page: 1)
    }

    static var movieRecommendations: MoviesRecommendationRequest {
        MoviesRecommendationRequest(page: 2, movieId: 1234)
    }
}

final class MoviesDataProviderTests: XCTestCase {
    private var subscriptions: Set<AnyCancellable> = Set<AnyCancellable>()
    var sut: MoviesDataProvider!

    override func setUp() {
        createMockConfig()
        sut = DefaultMoviesDataProvider(clientManager: MockNetworkClient())
    }

    override func tearDown() {
        sut = nil
    }

    func test_getTodayTrendingList_shouldReturnAnList() throws {
        MockingURLSession.resgister(MockedData.moviesListJSON.data)
        let expectation = expectation(description: "an movies list should come")

        sut.getTrendingList(of: .today,
                            query: MockRequestable.pageQuery)
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

        sut.getTrendingList(of: .today,
                            query: MockRequestable.pageQuery)
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

        sut.getMovieReviewList(query: MockRequestable.movieReviewQuery)
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

    func test_GetMovieListRecommendations_ShouldReturnAnList() {
        MockingURLSession.resgister(MockedData.moviesListJSON.data)
        let expectation = expectation(description: "an movies list should come")

        sut.getMovieList(of: .recommendations,
                         query: MockRequestable.movieRecommendations)
        .sinkToResult {
            switch $0 {
            case .success(let data):
                XCTAssertTrue(!data.results.isEmpty)
                XCTAssertEqual(data.results.first!.title, "Scream VI")
                expectation.fulfill()
            case .failure(let error):
                XCTFail("should not reach here, Error: \(error.localizedDescription)")            }
        }
        .store(in: &subscriptions)

        wait(for: [expectation], timeout: 2)
    }
}

extension URL {
    var data: Data {
        try! Data(contentsOf: self)
    }
}
