// MovieAPIServiceProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол сериса по работе с запросами
protocol MoviesAPIServiceProtocol {
    // MARK: - Public Methods

    func sendMoviesRequest(movieType: String, completion: @escaping (Result<Results, Error>) -> Void)
    func sendMovieInfoRequest(movieID: Int, completion: @escaping (Result<MovieInfo, Error>) -> Void)
}
