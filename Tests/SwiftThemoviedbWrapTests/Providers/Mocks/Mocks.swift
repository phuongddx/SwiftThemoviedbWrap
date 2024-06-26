//
//  Mocks.swift
//
//
//  Created by PhuongDoan on 21/6/24.
//

import Foundation
import XCTest
import SwiftNetworkWrap
@testable import SwiftThemoviedbWrap

final class MockTmdbNetworkSessionManager: TmdbNetworkSessionManager {
    override init(session: URLSession = .mockedResponseOnly,
                  bgQueue: DispatchQueue = DispatchQueue(label: "themoviedb_queue_testing")) {
        super.init(session: session, bgQueue: bgQueue)
    }
}

final class MockNetworkWrapProvider: TmdbNetworkWrapProvider {
    override init(sessionManager: TmdbNetworkSessionManager = MockTmdbNetworkSessionManager()) {
        super.init(sessionManager: sessionManager)
    }
}

extension XCTestCase {
    func createMockConfig() {
        NetworkWrapConfigurationTmdb.accessToken = "token"
        NetworkWrapConfigurationTmdb.apiKey = "key"
        NetworkWrapConfigurationTmdb.language = "en-US"
    }
}
