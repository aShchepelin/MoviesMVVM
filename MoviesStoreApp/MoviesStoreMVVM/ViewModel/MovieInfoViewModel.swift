// MovieInfoViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Вью модель экрана с информацией о фильме
final class MovieInfoViewModel: MovieInfoViewModelProtocol {
    // MARK: - Public Properties

    var showErrorAlert: ErrorHandler?
    var updateView: VoidHandler?
    var movieInfo: MovieInfo?
    var movieID: Int?

    // MARK: - Private Properties

    private let networkService: NetworkServiceProtocol?
    private var imageService: ImageServiceProtocol?

    // MARK: - Init

    init(
        networkService: NetworkServiceProtocol,
        movieID: Int,
        imageService: ImageServiceProtocol
    ) {
        self.networkService = networkService
        self.movieID = movieID
        self.imageService = imageService
    }

    // MARK: - Public Methods

    func loadMovieInfo() {
        fetchMovieInfo()
    }

    func fetchImage(url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        imageService?.getPhoto(byUrl: url) { result in
            switch result {
            case let .success(data):
                completion(.success(data))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    // MARK: - Private Methods

    private func fetchMovieInfo() {
        networkService?.fetchMovieInfo(movieID: movieID ?? 0) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(movie):
                self.movieInfo = movie
                self.updateView?()
            case let .failure(error):
                self.showErrorAlert?(error)
            }
        }
    }
}
