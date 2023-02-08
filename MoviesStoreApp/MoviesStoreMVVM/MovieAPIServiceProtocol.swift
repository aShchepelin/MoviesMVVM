// MovieAPIServiceProtocol.swift
// Copyright © Aleksandr Shchepelin. All rights reserved.

import Foundation

/// Протокол сериса по работе с запросами
protocol MoviesAPIServiceProtocol {
    var keyChainService: KeyChainServiceProtocol? { get }
    func sendMoviesRequest(movieType: String, completion: @escaping (Result<Results, Error>) -> Void)
    func sendMovieInfoRequest(movieID: Int, completion: @escaping (Result<MovieInfo, Error>) -> Void)
}
