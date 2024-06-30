//
//  TmdbApiTarget.swift
//
//
//  Created by PhuongDoan on 30/6/24.
//

import Foundation
import SwiftNetworkWrap

public struct TmdbBaseURLType: BaseURLType {
    public var rawValue: URL = URL(string: "https://api.themoviedb.org/3")!
}

public protocol TmdbApiTarget: NetworkTarget {
    var queryDefaultParams: [String: String] { get }
}

extension TmdbApiTarget {
    public var queryDefaultParams: [String: String] {
        [
            "api_key": NetworkWrapConfigurationTmdb.apiKey,
            "language": NetworkWrapConfigurationTmdb.language
        ]
    }

    public var baseURL: any BaseURLType {
        TmdbBaseURLType()
    }

    public var version: VersionType {
        .v2
    }

    public var methodType: HTTPMethod {
        .get
    }

    public var queryParamsEncoding: URLEncoding? {
        .default
    }
}
