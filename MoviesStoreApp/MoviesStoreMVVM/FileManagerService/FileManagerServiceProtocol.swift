// FileManagerServiceProtocol.swift
// Copyright © Aleksandr Shchepelin. All rights reserved.

import Foundation

/// Протокол файл менеджера
protocol FileManagerServiceProtocol {
    func saveImageToCache(url: String, data: Data)
    func getImageFromCache(url: String) -> Data?
}
