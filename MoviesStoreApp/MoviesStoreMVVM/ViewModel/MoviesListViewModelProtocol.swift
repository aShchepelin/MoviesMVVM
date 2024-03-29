// MoviesListViewModelProtocol.swift
// Copyright © Aleksandr Shchepelin. All rights reserved.

import Foundation

/// Протокол для вью модели экрана списка фильмов
protocol MoviesListViewModelProtocol {
    var updateView: VoidHandler? { get }
    var showErrorAlert: ErrorHandler? { get }
    var coreDataErrorHandler: CoreDataHandler? { get set }
    var movies: [Movie] { get }
    var moviesAPIService: MoviesAPIServiceProtocol { get }
    var moviesListState: ((MoviesListStates) -> ())? { get set }
    var movieCategory: MovieCategory { get set }

    func fetchTypeMovies(index: Int)
    func fetchImage(url: String, completion: @escaping (Result<Data, Error>) -> Void)
    func keyChainInfo() -> KeyChainServiceProtocol?
}
