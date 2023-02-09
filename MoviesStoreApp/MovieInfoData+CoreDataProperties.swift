// MovieInfoData+CoreDataProperties.swift
// Copyright © Aleksandr Shchepelin. All rights reserved.

import CoreData
import Foundation

/// База данных информации о фильме
public extension MovieInfoData {
    @nonobjc class func fetchRequest() -> NSFetchRequest<MovieInfoData> {
        NSFetchRequest<MovieInfoData>(entityName: "MovieInfoData")
    }

    @NSManaged var poster: String?
    @NSManaged var adult: Bool
    @NSManaged var originalTitle: String?
    @NSManaged var overview: String?
    @NSManaged var releaseDate: String?
    @NSManaged var movieId: Int64
    @NSManaged var title: String?
    @NSManaged var popularity: Float
    @NSManaged var voteCount: Int64
    @NSManaged var voteAverage: Float
    @NSManaged var runtime: Int64
    @NSManaged var imdbId: String?
    @NSManaged var genres: NSSet?
    @NSManaged var productionCountry: NSSet?
}

// MARK: Generated accessors for genres

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

// MARK: Generated accessors for productionCountry

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
