// FileManagerServiceProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол файл менеджера
protocol FileManagerServiceProtocol {
    // MARK: - Public Methods

    func saveImageToCache(url: String, data: Data)
    func getImageFromCache(url: String) -> Data?
}
