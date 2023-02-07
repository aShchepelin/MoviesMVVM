// ImageService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Сервис по кешированию изображений
final class ImageService: ImageServiceProtocol {
    // MARK: - Private Properties

    private let imageAPIService = ImageAPIService()
    private let fileManagerService = FileManagerService()

    // MARK: - Public Methods

    func getPhoto(byUrl url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let proxy = Proxy(imageAPIService: imageAPIService, fileManagerService: fileManagerService)
        proxy.loadImage(url: url) { result in
            switch result {
            case let .success(image):
                completion(.success(image))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
