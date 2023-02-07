// MoviesListViewModelProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол для вью модели экрана списка фильмов
protocol MoviesListViewModelProtocol {
    // MARK: - Public Properties

    var updateView: VoidHandler? { get set }
    var showErrorAlert: ErrorHandler? { get set }
    var movies: [Movies] { get set }
    var moviesAPIService: MoviesAPIServiceProtocol { get set }
    var moviesListState: ((MoviesListStates) -> ())? { get set }

    // MARK: - Public Methods

    func fetchMoviesData()
    func fetchTypeMovies(index: Int)
    func fetchImage(url: String, completion: @escaping (Result<Data, Error>) -> Void)
}
