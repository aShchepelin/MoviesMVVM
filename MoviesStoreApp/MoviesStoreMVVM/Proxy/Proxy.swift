// Proxy.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Прокси
final class Proxy: ProxyProtocol {
    // MARK: - Private Properties

    private let imageAPIService: ImageAPIServiceProtocol
    private let fileManagerService: FileManagerServiceProtocol

    // MARK: - Init

    init(imageAPIService: ImageAPIServiceProtocol, fileManagerService: FileManagerServiceProtocol) {
        self.imageAPIService = imageAPIService
        self.fileManagerService = fileManagerService
    }

    // MARK: - Public Methods

    func loadImage(url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let image = fileManagerService.getImageFromCache(url: url) else {
            imageAPIService.fetchImage(imageUrlPath: url) { [weak self] result in
                switch result {
                case let .success(data):
                    self?.fileManagerService.saveImageToCache(url: url, data: data)
                    completion(.success(data))
                case let .failure(error):
                    completion(.failure(error))
                }
            }
            return
        }
        completion(.success(image))
    }
}
