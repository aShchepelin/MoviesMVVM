// Movies.swift
// Copyright © Aleksandr Shchepelin. All rights reserved.

/// Модель фильмов
struct Movies: Codable {
    enum CodingKeys: String, CodingKey {
        case poster = "poster_path"
        case adult
        case originalTitle = "original_title"
        case overview
        case releaseDate = "release_date"
        case genre = "genre_ids"
        case movieId = "id"
        case title
        case popularity
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
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
    /// Жанр
    let genre: [Int]
    /// Идентификатор фильма
    let movieId: Int
    /// Название
    let title: String
    /// Рейтинг популярности
    let popularity: Float
    /// Количество голосов
    let voteCount: Int
    /// Средняя оценка
    let voteAverage: Float
}
