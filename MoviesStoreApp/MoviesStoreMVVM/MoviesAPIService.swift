// MoviesAPIService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Сервис по работе с запросами
final class MoviesAPIService: MoviesAPIServiceProtocol {
    // MARK: - Public Methods

    func sendMovieInfoRequest(movieID: Int, completion: @escaping (Result<MovieInfo, Error>) -> Void) {
        guard let url = URL(
            string: "\(URLRequest.baseURL)\(movieID)\(URLRequest.apiKey)"
        ) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else { return }
            do {
                let movies = try JSONDecoder().decode(MovieInfo.self, from: data)
                completion(.success(movies))
            } catch {
                completion(.failure(error))
            }
        }
        .resume()
    }

    func sendMoviesRequest(movieType: String, completion: @escaping (Result<Results, Error>) -> Void) {
        guard let url = URL(
            string: "\(URLRequest.baseURL)\(movieType)\(URLRequest.apiKey)"
        ) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else { return }
            do {
                let movies = try JSONDecoder().decode(Results.self, from: data)
                completion(.success(movies))
            } catch {
                completion(.failure(error))
            }
        }
        .resume()
    }
}
