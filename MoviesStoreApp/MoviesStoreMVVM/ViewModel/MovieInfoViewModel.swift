// MovieInfoViewModel.swift
// Copyright © Aleksandr Shchepelin. All rights reserved.

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
    private let coreDataService: CoreDataServiceProtocol?
    private var imageService: ImageServiceProtocol?

    // MARK: - Init

    init(
        networkService: NetworkServiceProtocol,
        movieID: Int,
        imageService: ImageServiceProtocol,
        coreDataService: CoreDataServiceProtocol
    ) {
        self.networkService = networkService
        self.movieID = movieID
        self.imageService = imageService
        self.coreDataService = coreDataService
    }

    // MARK: - Public Methods

    func loadMovieInfo() {
        guard let movieInfo = coreDataService?.getMovieInfoData(movieID: movieID ?? 0) else {
            fetchMovieInfo()
            return
        }
        self.movieInfo = movieInfo
        updateView?()
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
                self.coreDataService?.saveMovieInfoDataContext(movieInfo: movie)
                self.movieInfo = movie
                self.updateView?()
            case let .failure(error):
                self.showErrorAlert?(error)
            }
        }
    }
}
