// MoviesAPIService.swift
// Copyright © Aleksandr Shchepelin. All rights reserved.

import Foundation

/// Сервис по работе с запросами
final class MoviesAPIService: MoviesAPIServiceProtocol {
    // MARK: - Private Properties

    private var keyChainService: KeyChainServiceProtocol?

    // MARK: - Init

    init(keyChainService: KeyChainServiceProtocol) {
        self.keyChainService = keyChainService
    }

    // MARK: - Public Methods

    func sendMovieInfoRequest(movieID: Int, completion: @escaping (Result<MovieInfo, Error>) -> Void) {
        guard var urlComponetnts = URLComponents(string: "\(URLRequest.baseURL)\(movieID)") else { return }
        urlComponetnts.queryItems = [
            URLQueryItem(name: URLRequest.apiKey, value: keyChainService?.getValue(Constants.keyChainKey)),
            URLQueryItem(name: URLRequest.languageKey, value: URLRequest.languageValue)
        ]
        guard let url = urlComponetnts.url else { return }
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
        guard var urlComponetnts = URLComponents(string: "\(URLRequest.baseURL)\(movieType)") else { return }
        urlComponetnts.queryItems = [
            URLQueryItem(name: URLRequest.apiKey, value: keyChainService?.getValue(Constants.keyChainKey)),
            URLQueryItem(name: URLRequest.languageKey, value: URLRequest.languageValue)
        ]
        guard let url = urlComponetnts.url else { return }
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
