// MoviesListViewModel.swift
// Copyright © Aleksandr Shchepelin. All rights reserved.

import Foundation

/// Вью модель экрана списка фильмов
final class MoviesListViewModel: MoviesListViewModelProtocol {
    // MARK: - Public Properties

    var showErrorAlert: ErrorHandler?
    var moviesAPIService: MoviesAPIServiceProtocol
    var updateView: VoidHandler?
    var coreDataErrorHandler: CoreDataHandler?
    var moviesListState: ((MoviesListStates) -> ())?
    var movies: [Movie] = []

    // MARK: - Private Properties

    private let networkService: NetworkServiceProtocol
    private var coreDataService: CoreDataServiceProtocol?
    private var imageService: ImageServiceProtocol
    private var keyChainService: KeyChainServiceProtocol

    // MARK: - Init

    init(
        networkService: NetworkServiceProtocol,
        imageService: ImageServiceProtocol,
        moviesAPIService: MoviesAPIServiceProtocol,
        keyChainService: KeyChainServiceProtocol,
        coreDataService: CoreDataServiceProtocol
    ) {
        self.networkService = networkService
        self.imageService = imageService
        self.moviesAPIService = moviesAPIService
        self.keyChainService = keyChainService
        self.coreDataService = coreDataService
    }

    // MARK: - Public Methods

    func keyChainInfo() -> KeyChainServiceProtocol? {
        keyChainService
    }

    func fetchTypeMovies(index: Int) {
        switch index {
        case 0:
            loadData(movieType: URLRequest.topRatedRequest)
        case 1:
            loadData(movieType: URLRequest.popularRequest)
        case 2:
            loadData(movieType: URLRequest.upcomingRequest)
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
        loadData(movieType: URLRequest.popularRequest)
    }

    // MARK: - Private Methods

    private func loadData(movieType: String) {
        guard let movies = coreDataService?.getMovieData(movieType: movieType) else { return }
        if !movies.isEmpty {
            self.movies = movies
            moviesListState?(.success)
        } else {
            fetchMovies(movieType: movieType)
        }
    }

    private func fetchMovies(movieType: String) {
        networkService.fetchMovies(moviesType: movieType) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(movie):
                self.coreDataService?.saveMovieDataContext(movies: movie, movieType: movieType)
                self.movies = movie
                self.moviesListState?(.success)
            case let .failure(error):
                self.moviesListState?(.failure(error))
            }
        }
    }
}
