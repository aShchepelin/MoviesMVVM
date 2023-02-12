// MockFileManagerService.swift
// Copyright © Aleksandr Shchepelin. All rights reserved.

import Foundation
@testable import MoviesStoreMVVM

/// Мок сервиса файл менеджера
final class MockFileManagerService: FileManagerServiceProtocol {
    // MARK: - Constants

    private enum Constants {
        static let mockUrl = "foo"
        static let mockNumber = 0
    }

    // MARK: - Private Properties

    private let mockData = Data(count: Constants.mockNumber)

    // MARK: - Public Methods

    func saveImageToCache(url: String, data: Data) {
        FileManager.default.createFile(atPath: Constants.mockUrl, contents: mockData)
    }

    func getImageFromCache(url: String) -> Data? {
        mockData
    }
}
