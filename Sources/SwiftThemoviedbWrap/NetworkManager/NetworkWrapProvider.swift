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

public class TmdbNetworkSessionManager: NetworkSessionManager {
    public var session: URLSession
    public var baseURL: String
    public var bgQueue: DispatchQueue

    init(session: URLSession = .configuredURLSession(),
         baseURL: String = "https://api.themoviedb.org/3",
         bgQueue: DispatchQueue = DispatchQueue(label: "themoviedb_queue")) {
        self.session = session
        self.baseURL = baseURL
        self.bgQueue = bgQueue
    }
}

public class TmdbNetworkWrapProvider: NetworkWrapProvider {
    public var sessionManager: NetworkSessionManager

    init(sessionManager: NetworkSessionManager = TmdbNetworkSessionManager()) {
        self.sessionManager = sessionManager
    }
}
