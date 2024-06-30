//
//  NetworkWrapProvider.swift
//  
//
//  Created by PhuongDoan on 22/6/24.
//

import Foundation
import Combine
import SwiftNetworkWrap

public struct NetworkWrapConfigurationTmdb {
    private init() {}

    public static var apiKey: String = ""
    public static var accessToken: String = ""
    public static var language: String = NSLocale.preferredLanguages.first ?? "en-US"
}

open class TmdbNetworkClientManager: NetworkClientManager<DefaultHTTPRequest> {
    public override init(clientURLSession: any NetworkClient = DefaultNetworkClient()) {
        super.init(clientURLSession: clientURLSession)
    }

    public func request<Model: Decodable>(
        _ target: TmdbApiTarget,
        scheduler: any Scheduler = WorkScheduler.mainScheduler
    ) -> AnyPublisherResult<Model> {
        self.request(DefaultHTTPRequest(request: target),
                     scheduler: scheduler,
                     responseObject: Model.self)
    }
}

public final class WorkScheduler {
    static var backgroundWorkScheduler: OperationQueue = {
        let operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = 5
        operationQueue.qualityOfService = QualityOfService.userInitiated
        return operationQueue
    }()

    public static let mainScheduler = RunLoop.main
    public static let mainThread = DispatchQueue.main
}
