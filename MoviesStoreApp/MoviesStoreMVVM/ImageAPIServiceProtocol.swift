// ImageAPIServiceProtocol.swift
// Copyright © Aleksandr Shchepelin. All rights reserved.

import Foundation

/// Протокол сервиса загрузки изображения из сети
protocol ImageAPIServiceProtocol {
    func fetchImage(imageUrlPath: String, completion: @escaping (Result<Data, Error>) -> Void)
}
