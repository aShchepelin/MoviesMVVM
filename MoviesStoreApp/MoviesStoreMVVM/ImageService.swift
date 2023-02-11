// ImageService.swift
// Copyright © Aleksandr Shchepelin. All rights reserved.

import Foundation

/// Сервис по кешированию изображений
final class ImageService: ImageServiceProtocol {
    // MARK: - Private Properties

    private let proxy: ProxyProtocol?

    init(proxy: ProxyProtocol?) {
        self.proxy = proxy
    }

    // MARK: - Public Methods

    func getPhoto(byUrl url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        proxy?.loadImage(url: url) { result in
            switch result {
            case let .success(image):
                completion(.success(image))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
