//
//  MockedResponse.swift
//
//
//  Created by PhuongDoan on 21/6/24.
//

import Foundation
import SwiftNetworkWrap

extension RequestMocking {
    struct MockedResponse {
        let url: URL
        let result: Result<Data, Swift.Error>
        let httpCode: HTTPCode
        let headers: [String: String]
        let loadingTime: TimeInterval
        let customResponse: URLResponse?
    }
}
