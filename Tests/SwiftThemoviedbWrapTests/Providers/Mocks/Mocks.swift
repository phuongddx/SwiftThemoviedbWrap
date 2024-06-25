//
//  Mocks.swift
//
//
//  Created by PhuongDoan on 21/6/24.
//

import Foundation
import SwiftNetworkWrap
@testable import SwiftThemoviedbWrap

final class MockNetworkSessionManager: NetworkSessionManager {
    let session: URLSession
    let baseURL: String
    let bgQueue = DispatchQueue(label: "bg_parse_queue")

    init(session: URLSession = .mockedResponseOnly,
         baseURL: String = "https://testing.com") {
        self.session = session
        self.baseURL = baseURL
    }
}

final class MockNetworkWrapProvider: NetworkWrapProvider {
    var sessionManager: any NetworkSessionManager

    init(sessionManager: any NetworkSessionManager = MockNetworkSessionManager()) {
        self.sessionManager = sessionManager
    }
}

class MockTmdbConfiguration: TmdbConfiguration {}

extension TmdbConfiguration {
    static var mock: MockTmdbConfiguration {
        MockTmdbConfiguration(accessToken: "token", apiKey: "apikey")
    }
}
