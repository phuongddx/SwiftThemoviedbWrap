//
//  NetworkWrapProvider.swift
//  
//
//  Created by PhuongDoan on 22/6/24.
//

import Foundation
import Combine
import SwiftNetworkWrap

public protocol NetworkWrapProvider {
    var sessionManager: NetworkSessionManager { get }
}

extension NetworkWrapProvider {
    func request<Value: Decodable>(_ target: ApiTarget) -> AnyPublisher<Value, Error> {
        sessionManager.call(target)
    }
}

public class DefaultNetworkWrapProvider: NetworkWrapProvider {
    public var sessionManager: NetworkSessionManager

    init(sessionManager: NetworkSessionManager = DefaultNetworkSessionManager(baseURL: "")) {
        self.sessionManager = sessionManager
    }
}
