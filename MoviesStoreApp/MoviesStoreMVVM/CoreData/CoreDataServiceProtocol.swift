// CoreDataServiceProtocol.swift
// Copyright © Aleksandr Shchepelin. All rights reserved.

import Foundation

/// Протокол сервиса по обрабокте данных в CoreData
protocol CoreDataServiceProtocol {
    var errorHandler: CoreDataHandler? { get set }
    func saveMovieDataContext(movies: [Movie], movieType: String)
    func saveMovieInfoDataContext(movieInfo: MovieInfo)
    func getMovieInfoData(movieID: Int) -> MovieInfo?
    func getMovieData(movieType: String) -> [Movie]
}
