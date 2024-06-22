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

    private var subscriptions = Set<AnyCancellable>()
    var sut: MoviesDataProvider!

    override func setUp() {
        sut = DefaultMoviesDataProvider(provider: MockNetworkWrapProvider())
    }

    override func tearDown() {
        RequestMocking.removeAllMocks()
    }

    func test_getTodayTrendingList_shouldReturnAnList() throws {
        let target = MoviesTarget.todayTrending(request: DefaultMoviesRequestDTO(page: 2))
        try mock(target, result: .success(MoviesResponseDTO.mocked))
        let expectation = expectation(description: "an movies list should come")

        sut.getTrendingList(type: .today,
                            requestDTO: DefaultMoviesRequestDTO(page: 2))
            .sinkToResult { result in
                switch result {
                case .success(let moviesDTO):
                    XCTAssertTrue(!moviesDTO.movies.isEmpty)
                    XCTAssertEqual(moviesDTO.movies.first!.title, "Inception")
                    expectation.fulfill()
                default:
                    XCTFail("should not reach here")
                }
            }
            .store(in: &subscriptions)

        wait(for: [expectation], timeout: 3)
    }

    func test_getTodayTrendingList_shouldFailure() throws {
        let requestDTO = DefaultMoviesRequestDTO(page: 2)
        let mockFailure = Mock(url: URL(string: "https://testing.com")!,
                               result: .failure(ApiError.unexpectedResponse))
        RequestMocking.add(mock: mockFailure)
        let expectation = expectation(description: "an failure error come")

        sut.getTrendingList(type: .today,
                            requestDTO: requestDTO)
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

    private func mock<T>(_ target: ApiTarget, result: Result<T, Swift.Error>,
                         httpCode: HTTPCode = 200) throws where T: Encodable {
        let mock = try Mock(target: target,
                            baseURL: "https://testing.com",
                            result: result,
                            httpCode: httpCode)
        RequestMocking.add(mock: mock)
    }
}

extension MoviesResponseDTO {
    static var mocked: MoviesResponseDTO {
        MoviesResponseDTO(page: 1,
                          totalPages: 10,
                          movies: [
                            MoviesResponseDTO.MovieDTO(
                                id: 123,
                                title: "Inception",
                                posterPath: "/poster/inception.jpg",
                                overview: "A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a C.E.O.",
                                releaseDate: "2010-07-16",
                                voteAverage: 8.8
                            ),
                            MoviesResponseDTO.MovieDTO(
                                id: 124,
                                title: "The Matrix",
                                posterPath: "/poster/thematrix.jpg",
                                overview: "A computer hacker learns from mysterious rebels about the true nature of his reality and his role in the war against its controllers.",
                                releaseDate: "1999-03-31",
                                voteAverage: 8.7
                            )
                          ])
    }

    static var moviesDTOMocked: MoviesResponseDTO.MovieDTO {
        MoviesResponseDTO.MovieDTO(
            id: 123,
            title: "Inception",
            posterPath: "/poster/inception.jpg",
            overview: "A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a C.E.O.",
            releaseDate: "2010-07-16",
            voteAverage: 8.8
        )
    }
}
