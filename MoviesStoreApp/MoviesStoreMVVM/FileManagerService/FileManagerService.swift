// FileManagerService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Сервис файл менеджера
final class FileManagerService: FileManagerServiceProtocol {
    // MARK: - Private Enum

    private enum Constants {
        static let folderName = "Images"
        static let separator = "/"
        static let defaultString: Substring = "default"
        static let defaultImageName = "photo"
    }

    // MARK: - Public Methods

    func getImageFromCache(url: String) -> Data? {
        guard let filePath = getImagePath(url: url),
              let info = try? FileManager.default.attributesOfItem(atPath: filePath),
              let modificationDate = info[FileAttributeKey.modificationDate] as? Date
        else { return nil }
        let lifeTime = Date().timeIntervalSince(modificationDate)
        let fileNameURL = URL(filePath: filePath)
        let image = try? Data(contentsOf: fileNameURL)
        return image
    }

    func saveImageToCache(url: String, data: Data) {
        guard let filePath = getImagePath(url: url) else { return }
        FileManager.default.createFile(atPath: filePath, contents: data)
    }

    // MARK: - Private Methods

    private func getImagePath(url: String) -> String? {
        guard let folderUrl = getCacheFolderPath() else { return nil }
        let fileName = String(url.split(separator: Constants.separator).last ?? Constants.defaultString)
        return folderUrl.appendingPathComponent(fileName).path
    }

    private func getCacheFolderPath() -> URL? {
        guard let docsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        else { return nil }
        let url = docsDirectory.appendingPathComponent(Constants.folderName, isDirectory: true)
        if !FileManager.default.fileExists(atPath: url.path) {
            try? FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
        }
        return url
    }
}
