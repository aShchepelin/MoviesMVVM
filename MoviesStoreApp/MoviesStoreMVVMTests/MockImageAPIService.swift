// MockImageAPIService.swift
// Copyright © Aleksandr Shchepelin. All rights reserved.

import Foundation
@testable import MoviesStoreMVVM

/// Мок сервиса по загрузке картинок
final class MockImageAPIService: ImageAPIServiceProtocol {
    // MARK: - Private Enum

    private enum Constants {
        static let mockImageUrl = "foo"
        static let mockNumber = 0
    }

    // MARK: - Private Properties

    private var mockData = Data(count: Constants.mockNumber)

    // MARK: - Public Methods

    func fetchImage(imageUrlPath imageUrl: String, completion: @escaping (Result<Data, Error>) -> Void) {
        completion(.success(mockData))
    }
}
