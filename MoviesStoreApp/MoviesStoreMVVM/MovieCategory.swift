// MovieCategory.swift
// Copyright © Aleksandr Shchepelin. All rights reserved.

import Foundation

/// Категория фильмов
enum MovieCategory: String {
    /// Популярные
    case popular
    /// Топ рейтинг
    case topRated = "top_rated"
    /// Скоро в показе
    case upcoming
}
