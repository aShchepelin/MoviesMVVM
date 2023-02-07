// ImageAPIServiceProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол сервиса загрузки изображения из сети
protocol ImageAPIServiceProtocol {
    // MARK: - Public Methods

    func fetchImage(imageUrlPath: String, completion: @escaping (Result<Data, Error>) -> Void)
}
