// ImageServiceProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол  сервиса по кэшированию изображений
protocol ImageServiceProtocol {
    // MARK: - Public Methods

    func getPhoto(byUrl url: String, completion: @escaping (Result<Data, Error>) -> Void)
}
