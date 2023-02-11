// MovieInfoViewModelProtocol.swift
// Copyright © Aleksandr Shchepelin. All rights reserved.

import Foundation

/// Протокол вью модели экрана с информацией о фильме
protocol MovieInfoViewModelProtocol {
    var updateView: VoidHandler? { get set }
    var showErrorAlert: ErrorHandler? { get set }
    var movieID: Int? { get }
    var movieInfo: MovieInfo? { get }

    func loadMovieInfo()
    func fetchImage(url: String, completion: @escaping (Result<Data, Error>) -> Void)
}
