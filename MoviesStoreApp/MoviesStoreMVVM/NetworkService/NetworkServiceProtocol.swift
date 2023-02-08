// NetworkServiceProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол сетевого слоя
protocol NetworkServiceProtocol {
    func fetchMovies(moviesType: String, completion: @escaping (Result<[Movies], Error>) -> Void)
    func fetchMovieInfo(movieID: Int?, completion: @escaping (Result<MovieInfo, Error>) -> Void)
}
