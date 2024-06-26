//
//  Mocks.swift
//
//
//  Created by PhuongDoan on 21/6/24.
//

import Combine
import XCTest
import SwiftNetworkWrap
@testable import SwiftThemoviedbWrap

final class MockTmdbNetworkWrapProvider: TmdbNetworkWrapProvider {
    let session: URLSession

    init(session: URLSession) {
        self.session = session
    }

    func request<Response>(_ target: any TmdbApiTarget,
                           httpCodes: HTTPCodes) -> AnyPublisher<Response, any Error> where Response : Decodable {
        return Fail<Response, Error>(error: ApiError.imageDeserialization).eraseToAnyPublisher()
    }
}

extension XCTestCase {
    func createMockConfig() {
        NetworkWrapConfigurationTmdb.accessToken = "token"
        NetworkWrapConfigurationTmdb.apiKey = "key"
        NetworkWrapConfigurationTmdb.language = "en-US"
    }
}
