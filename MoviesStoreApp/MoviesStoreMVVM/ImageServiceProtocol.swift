// ImageServiceProtocol.swift
// Copyright © Aleksandr Shchepelin. All rights reserved.

import Foundation

/// Протокол  сервиса по кэшированию изображений
protocol ImageServiceProtocol {
    func getPhoto(byUrl url: String, completion: @escaping (Result<Data, Error>) -> Void)
}
