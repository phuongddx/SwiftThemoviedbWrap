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
    var baseURL: String
    var session: URLSession
    var bgQueue: DispatchQueue = DispatchQueue(label: "themoviedb_testing")

    init(baseURL: String = "https://testing.com",
         session: URLSession = .mockedResponseOnly) {
        self.baseURL = baseURL
        self.session = session
    }
}

extension XCTestCase {
    func createMockConfig() {
        NetworkWrapConfigurationTmdb.accessToken = "token"
        NetworkWrapConfigurationTmdb.apiKey = "key"
        NetworkWrapConfigurationTmdb.language = "en-US"
    }
}
