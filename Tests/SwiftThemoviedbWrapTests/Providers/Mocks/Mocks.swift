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

extension URLSession {
    static var mock: URLSession {
        MockingURLSession.shared
    }
}

final class MockedData {
    static let moviesListJSON: URL = Bundle.module.url(forResource: "movie_list", withExtension: "json")!
    static let reviewListJSON: URL = Bundle.module.url(forResource: "review_list", withExtension: "json")!
}

extension XCTestCase {
    func createMockConfig() {
        NetworkWrapConfigurationTmdb.accessToken = "token"
        NetworkWrapConfigurationTmdb.apiKey = "key"
        NetworkWrapConfigurationTmdb.language = "en-US"
    }
}
