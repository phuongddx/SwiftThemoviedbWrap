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

final class MockTmdbNetworkWrapProvider: TmdbNetworkWrapProvider {
    let session: URLSession
    let baseURL: URL

    init(session: URLSession = .mockedResponseOnly,
         baseURL: URL = URL(string: "https://testing.com")!) {
        self.session = session
        self.baseURL = baseURL
    }
}

extension XCTestCase {
    func createMockConfig() {
        NetworkWrapConfigurationTmdb.accessToken = "token"
        NetworkWrapConfigurationTmdb.apiKey = "key"
        NetworkWrapConfigurationTmdb.language = "en-US"
    }
}
