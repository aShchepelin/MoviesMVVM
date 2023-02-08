// Results.swift
// Copyright © Aleksandr Shchepelin. All rights reserved.

import Foundation

/// Структура для парсинга результата
struct Results: Codable {
    enum CodingKeys: String, CodingKey {
        case movies = "results"
    }

    /// Фильмы
    let movies: [Movies]
}
