// NetworkService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Сервис по запросу данных с API
final class NetworkService: NetworkServiceProtocol {
    // MARK: - Private Properties

    private var moviesAPIService: MoviesAPIServiceProtocol

    // MARK: - Init

    init(moviesAPIService: MoviesAPIServiceProtocol) {
        self.moviesAPIService = moviesAPIService
    }

    // MARK: - Public Methods

    func fetchMovies(moviesType: String, completion: @escaping (Result<[Movies], Error>) -> Void) {
        moviesAPIService.sendMoviesRequest(movieType: moviesType) { result in
            switch result {
            case let .success(data):
                let movies = data.movies
                completion(.success(movies))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    func fetchMovieInfo(movieID: Int?, completion: @escaping (Result<MovieInfo, Error>) -> Void) {
        moviesAPIService.sendMovieInfoRequest(movieID: movieID ?? 0) { result in
            switch result {
            case let .success(data):
                completion(.success(data))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
