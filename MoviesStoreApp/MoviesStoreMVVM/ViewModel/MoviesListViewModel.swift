// MoviesListViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Вью модель экрана списка фильмов
final class MoviesListViewModel: MoviesListViewModelProtocol {
    // MARK: - Public Properties

    var showErrorAlert: ErrorHandler?
    var moviesAPIService: MoviesAPIServiceProtocol
    var updateView: VoidHandler?
    var moviesListState: ((MoviesListStates) -> ())?
    var movies: [Movies] = []

    // MARK: - Private Properties

    private let networkService: NetworkServiceProtocol
    private var imageService: ImageServiceProtocol

    // MARK: - Init

    init(
        networkService: NetworkServiceProtocol,
        imageService: ImageServiceProtocol,
        moviesAPIService: MoviesAPIServiceProtocol
    ) {
        self.networkService = networkService
        self.imageService = imageService
        self.moviesAPIService = moviesAPIService
    }

    // MARK: - Public Methods

    func fetchTypeMovies(index: Int) {
        switch index {
        case 0:
            fetchMovies(movieType: URLRequest.topRatedRequest)
        case 1:
            fetchMovies(movieType: URLRequest.popularRequest)
        case 2:
            fetchMovies(movieType: URLRequest.upcomingRequest)
        default:
            break
        }
    }

    func fetchImage(url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        imageService.getPhoto(byUrl: url) { result in
            switch result {
            case let .success(data):
                completion(.success(data))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    func fetchMoviesData() {
        fetchMovies(movieType: URLRequest.popularRequest)
    }

    // MARK: - Private Methods

    private func fetchMovies(movieType: String) {
        networkService.fetchMovies(moviesType: movieType) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(movie):
                self.movies = movie
                self.moviesListState?(.success)
            case let .failure(error):
                self.moviesListState?(.failure(error))
            }
        }
    }
}
