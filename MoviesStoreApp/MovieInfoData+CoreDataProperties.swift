// MovieInfoData+CoreDataProperties.swift
// Copyright © Aleksandr Shchepelin. All rights reserved.

import CoreData
import Foundation

/// База данных информации о фильме
public extension MovieInfoData {
    @nonobjc class func fetchRequest() -> NSFetchRequest<MovieInfoData> {
        NSFetchRequest<MovieInfoData>(entityName: "MovieInfoData")
    }

    /// Постер
    @NSManaged var poster: String?
    /// Возрастное ограничение
    @NSManaged var adult: Bool
    /// Название на оригинальном языке
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
    /// Длительность фильма
    @NSManaged var runtime: Int64
    /// Идентификатор IMDB
    @NSManaged var imdbId: String?
    /// Жанры
    @NSManaged var genres: NSSet?
    /// Страна производства
    @NSManaged var productionCountry: NSSet?
}

/// Generated accessors for genres

public extension MovieInfoData {
    @objc(addGenresObject:)
    @NSManaged func addToGenres(_ value: GenresData)

    @objc(removeGenresObject:)
    @NSManaged func removeFromGenres(_ value: GenresData)

    @objc(addGenres:)
    @NSManaged func addToGenres(_ values: NSSet)

    @objc(removeGenres:)
    @NSManaged func removeFromGenres(_ values: NSSet)
}

/// Generated accessors for productionCountry

public extension MovieInfoData {
    @objc(addProductionCountryObject:)
    @NSManaged func addToProductionCountry(_ value: ProductionCountriesData)

    @objc(removeProductionCountryObject:)
    @NSManaged func removeFromProductionCountry(_ value: ProductionCountriesData)

    @objc(addProductionCountry:)
    @NSManaged func addToProductionCountry(_ values: NSSet)

    @objc(removeProductionCountry:)
    @NSManaged func removeFromProductionCountry(_ values: NSSet)
}
