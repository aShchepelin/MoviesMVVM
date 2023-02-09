// MovieData+CoreDataProperties.swift
// Copyright © Aleksandr Shchepelin. All rights reserved.

import CoreData
import Foundation

/// База данных фильма
public extension MovieData {
    @nonobjc class func fetchRequest() -> NSFetchRequest<MovieData> {
        NSFetchRequest<MovieData>(entityName: "MovieData")
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
    @NSManaged var id: UUID?
    @NSManaged var movieType: String?
}

/// Identifiable
extension MovieData: Identifiable {}
