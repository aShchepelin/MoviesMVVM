// MoviesAPIService.swift
// Copyright © Aleksandr Shchepelin. All rights reserved.

import Foundation

/// Сервис по работе с запросами
final class MoviesAPIService: MoviesAPIServiceProtocol {
    // MARK: - Public Properties

    var keyChainService: KeyChainServiceProtocol?

    // MARK: - Init

    init(keyChainService: KeyChainServiceProtocol) {
        self.keyChainService = keyChainService
    }

    // MARK: - Public Methods

    func sendMovieInfoRequest(movieID: Int, completion: @escaping (Result<MovieInfo, Error>) -> Void) {
        guard let url = URL(
            string: "\(URLRequest.baseURL)\(movieID)\(keyChainService?.getValue(Constants.keyChainKey) ?? "")"
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
            string: "\(URLRequest.baseURL)\(movieType)\(keyChainService?.getValue(Constants.keyChainKey) ?? "")"
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
