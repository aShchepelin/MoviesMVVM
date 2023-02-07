// MovieInfoViewModelProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол вью модели экрана с информацией о фильме
protocol MovieInfoViewModelProtocol {
    // MARK: - Public Properties

    var updateView: VoidHandler? { get set }
    var showErrorAlert: ErrorHandler? { get set }
    var movieID: Int? { get set }
    var movieInfo: MovieInfo? { get set }

    // MARK: - Public Methods

    func loadMovieInfo()
    func fetchImage(url: String, completion: @escaping (Result<Data, Error>) -> Void)
}
