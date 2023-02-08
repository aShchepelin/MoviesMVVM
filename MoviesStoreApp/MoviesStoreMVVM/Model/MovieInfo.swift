// MovieInfo.swift
// Copyright © Aleksandr Shchepelin. All rights reserved.

import Foundation

/// Модель конкректного фильма
struct MovieInfo: Codable {
    enum CodingKeys: String, CodingKey {
        case poster = "poster_path"
        case adult
        case originalTitle = "original_title"
        case overview
        case releaseDate = "release_date"
        case genres
        case movieId = "id"
        case title
        case popularity
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
        case productionCountries = "production_countries"
        case runtime
        case imdbId = "imdb_id"
    }

    /// Постер
    let poster: String
    /// Возрастное ограничение
    let adult: Bool
    /// Название на оригинальном языке
    let originalTitle: String
    /// Описание фильма
    let overview: String
    /// Дата релиза
    let releaseDate: String
    /// Жанры
    let genres: [Genre]
    /// Идентификатор фильма
    let movieId: Int
    /// Название фильма
    let title: String
    /// Рейтинг популярности
    let popularity: Float
    /// Количество голосов
    let voteCount: Int
    /// Средний голос
    let voteAverage: Float
    /// Страна производства
    let productionCountries: [ProductionCountry]
    /// Длительность фильма
    let runtime: Int
    /// Идентификатор IMDB
    let imdbId: String
}
