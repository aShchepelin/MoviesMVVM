// ImageAPIService.swift
// Copyright © Aleksandr Shchepelin. All rights reserved.

import Foundation

/// Сервис загрузки изображения из сети
final class ImageAPIService: ImageAPIServiceProtocol {
    // MARK: - Private Properties

    private var dataTask: URLSessionDataTask?

    // MARK: - Public Methods

    func fetchImage(imageUrlPath: String, completion: @escaping (Result<Data, Error>) -> ()) {
        guard let url = URL(string: "\(URLRequest.imageURL)\(imageUrlPath)") else { return }
        dataTask = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                return
            }
            DispatchQueue.main.async {
                completion(.success(data))
            }
        }
        dataTask?.resume()
    }
}
