// MockImageService.swift
// Copyright © Aleksandr Shchepelin. All rights reserved.

import Foundation
@testable import MoviesStoreMVVM

/// Мок сервиса по кэшированию картинок
final class MockImageService: ImageServiceProtocol {
    // MARK: - Public Methods

    func getPhoto(byUrl url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        do { guard let data = url.data(using: .utf8) else { return }
            completion(.success(data))
        } catch {
            completion(.failure(error))
        }
    }
}
