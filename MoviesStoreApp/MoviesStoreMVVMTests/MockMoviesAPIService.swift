// MockMoviesAPIService.swift
// Copyright © Aleksandr Shchepelin. All rights reserved.

import Foundation
@testable import MoviesStoreMVVM

/// Мок сервиса по запросу API
final class MockMoviesAPIService: MoviesAPIServiceProtocol {
    
    // MARK: - Public Methods
    
    func sendMoviesRequest(movieType: String, completion: @escaping (Result<MoviesStoreMVVM.Results, Error>) -> Void) {
        guard let jsonURL = Bundle.main.path(forResource: UnitTest.mockMovieJSON, ofType: UnitTest.jsonType)
        else { return }
        do {
            let fileURL = URL(fileURLWithPath: jsonURL)
            let data = try Data(contentsOf: fileURL)
            let result = try JSONDecoder().decode(Results.self, from: data)
            completion(.success(result))
        } catch {
            completion(.failure(error))
        }
    }

    func sendMovieInfoRequest(movieID: Int, completion: @escaping (Result<MovieInfo, Error>) -> Void) {
        guard let jsonURL = Bundle.main.path(forResource: UnitTest.mockMovieInfoJSON, ofType: UnitTest.jsonType)
        else { return }
        do {
            let fileURL = URL(fileURLWithPath: jsonURL)
            let data = try Data(contentsOf: fileURL)
            let result = try JSONDecoder().decode(MovieInfo.self, from: data)
            completion(.success(result))
        } catch {
            completion(.failure(error))
        }
    }
}
