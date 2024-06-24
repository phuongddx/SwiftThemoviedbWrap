//
//  PagedPersonResponseTests.swift
//  
//
//  Created by PhuongDoan on 24/6/24.
//

import Foundation
import XCTest
@testable import SwiftThemoviedbWrap

final class PagedPersonResponseTests: XCTestCase {
    override func setUp() {
    }

    func test_DecodingPagedPerson_shouldSuccess() throws {
        let actual = PersonPagedResponse.mock

        XCTAssertFalse(actual.results.isEmpty)
        XCTAssertEqual(actual.results.first?.name, "Tom Cruise")
    }
}
