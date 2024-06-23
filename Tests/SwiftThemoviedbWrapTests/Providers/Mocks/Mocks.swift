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

class MockTMDBConfigurationManager: TMDBConfigurationManagerProtocol {
    var accessToken: String
    var apiKey: String
    var language: String

    init(accessToken: String = "token",
         apiKey: String = "key",
         language: String = "en") {
        self.accessToken = accessToken
        self.apiKey = apiKey
        self.language = language
    }

    func validateCredentials() throws {
        if accessToken.isEmpty && apiKey.isEmpty {
            throw TmdbApiError.invalidCredentials
        }
    }
}
