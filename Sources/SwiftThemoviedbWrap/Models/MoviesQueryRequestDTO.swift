//
//  MoviesQueryRequestDTO.swift
//  
//
//  Created by PhuongDoan on 21/6/24.
//

import Foundation

protocol MoviesRequestable: Encodable {
    var page: Int { get set }
}

struct MoviesQueryRequestDTO: MoviesRequestable {
    let query: String
    var page: Int
}

struct DefaultMoviesRequestDTO: MoviesRequestable {
    var page: Int

    init(page: Int = 1) {
        self.page = page
    }
}
