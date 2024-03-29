// NetworkServiceProtocol.swift
// Copyright © Aleksandr Shchepelin. All rights reserved.

import Foundation

/// Протокол сетевого слоя
protocol NetworkServiceProtocol {
    func fetchMovies(moviesType: String, completion: @escaping (Result<[Movie], Error>) -> Void)
    func fetchMovieInfo(movieID: Int?, completion: @escaping (Result<MovieInfo, Error>) -> Void)
}
