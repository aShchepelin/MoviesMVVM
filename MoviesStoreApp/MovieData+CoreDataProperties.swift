// MovieData+CoreDataProperties.swift
// Copyright © Aleksandr Shchepelin. All rights reserved.

import CoreData
import Foundation

/// База данных фильма
public extension MovieData {
    @nonobjc class func fetchRequest() -> NSFetchRequest<MovieData> {
        NSFetchRequest<MovieData>(entityName: "MovieData")
    }

    /// Постер
    @NSManaged var poster: String?
    /// Возрастное ограничение
    @NSManaged var adult: Bool
    /// Название фильма на оригинальном языке
    @NSManaged var originalTitle: String?
    /// Описание фильма
    @NSManaged var overview: String?
    /// Дата релиза
    @NSManaged var releaseDate: String?
    /// Идентификатор фильма
    @NSManaged var movieId: Int64
    /// Название фильма
    @NSManaged var title: String?
    /// Рейтинг популярности
    @NSManaged var popularity: Float
    /// Количество голосов
    @NSManaged var voteCount: Int64
    /// Средняя оценка
    @NSManaged var voteAverage: Float
    /// Уникальный идентификатор
    @NSManaged var id: UUID?
    /// Тип фильма
    @NSManaged var movieType: String?
}

/// Identifiable
extension MovieData: Identifiable {}
