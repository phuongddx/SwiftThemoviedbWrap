//
//  SearchDataProvider.swift
//
//
//  Created by PhuongDoan on 24/6/24.
//

import Foundation
import Combine

protocol SearchDataProvider {
    func movies(request: SearchRequest) -> AnyPublisher<MoviesResponse, Error>
    func persons(_ request: SearchRequest) -> AnyPublisher<Data, Error>
}
