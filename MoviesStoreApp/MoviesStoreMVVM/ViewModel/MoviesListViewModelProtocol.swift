// MoviesListViewModelProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол для вью модели экрана списка фильмов
protocol MoviesListViewModelProtocol {
    var updateView: VoidHandler? { get }
    var showErrorAlert: ErrorHandler? { get }
    var movies: [Movies] { get }
    var moviesAPIService: MoviesAPIServiceProtocol { get }
    var moviesListState: ((MoviesListStates) -> ())? { get set }

    func fetchMoviesData()
    func fetchTypeMovies(index: Int)
    func fetchImage(url: String, completion: @escaping (Result<Data, Error>) -> Void)
}
