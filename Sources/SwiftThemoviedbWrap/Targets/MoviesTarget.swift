//
//  MoviesTarget.swift
//  
//
//  Created by PhuongDoan on 21/6/24.
//

import Foundation
import SwiftNetworkWrap

enum MoviesTarget: ApiTarget {
    case upComing
    case todayTrending

    var path: String {
        ""
    }

    var method: String {
        "GET"
    }

    var hearders: [String : String]? {
        ["Content-type": "application/json"]
    }

    func body() throws -> Data? {
        Data()
    }
}
