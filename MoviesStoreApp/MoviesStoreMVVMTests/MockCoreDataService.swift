// MockCoreDataService.swift
// Copyright © Aleksandr Shchepelin. All rights reserved.

import Foundation
@testable import MoviesStoreMVVM

/// Мок сервиса по сохранению данных в CoreData
final class MockCoreDataService: CoreDataServiceProtocol {
    // MARK: - Public Properties

    var movieInfo: MovieInfo?
    var movie: [Movie] = []

    var errorHandler: MoviesStoreMVVM.CoreDataHandler?

    // MARK: - Private Methods

    func saveMovieDataContext(movies: [MoviesStoreMVVM.Movie], movieType: String) {}

    func saveMovieInfoDataContext(movieInfo: MoviesStoreMVVM.MovieInfo) {}

    func getMovieInfoData(movieID: Int) -> MoviesStoreMVVM.MovieInfo? {
        movieInfo
    }

    func getMovieData(movieType: String) -> [MoviesStoreMVVM.Movie] {
        movie
    }
}
