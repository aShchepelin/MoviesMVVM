// GenresData+CoreDataProperties.swift
// Copyright © Aleksandr Shchepelin. All rights reserved.

import CoreData
import Foundation

/// Связь базы данных жанров и информации о фильме
public extension GenresData {
    @nonobjc class func fetchRequest() -> NSFetchRequest<GenresData> {
        NSFetchRequest<GenresData>(entityName: "GenresData")
    }

    @NSManaged var name: String?
    @NSManaged var movieInfo: MovieInfoData?
}
