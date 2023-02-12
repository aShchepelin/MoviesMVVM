// MockNetworkService.swift
// Copyright © Aleksandr Shchepelin. All rights reserved.

import Foundation
@testable import MoviesStoreMVVM

/// Мок сервиса по запросу данных с API
final class MockNetworkService: NetworkServiceProtocol {
    // MARK: - Private Properties

    private let mockMovieAPIService = MockMoviesAPIService()
    private var movie: [Movie]?
    private var movieInfo: MovieInfo?

    // MARK: - Init

    init() {}

    convenience init(movie: [Movie]?) {
        self.init()
        self.movie = movie
    }

    convenience init(movieInfo: MovieInfo?) {
        self.init()
        self.movieInfo = movieInfo
    }

    // MARK: - Public Methods

    func fetchMovieInfo(movieID: Int?, completion: @escaping (Result<MoviesStoreMVVM.MovieInfo, Error>) -> Void) {
        mockMovieAPIService.sendMovieInfoRequest(movieID: movieID ?? 0) { result in
            switch result {
            case let .success(data):
                completion(.success(data))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    func fetchMovies(moviesType: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        mockMovieAPIService.sendMoviesRequest(movieType: moviesType) { result in
            switch result {
            case let .success(data):
                let movies = data.movies
                completion(.success(movies))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
