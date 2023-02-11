// ProductionCountriesData+CoreDataProperties.swift
// Copyright © Aleksandr Shchepelin. All rights reserved.

import CoreData
import Foundation

/// Связь базы данных стран производства и информации о фильме
public extension ProductionCountriesData {
    @nonobjc class func fetchRequest() -> NSFetchRequest<ProductionCountriesData> {
        NSFetchRequest<ProductionCountriesData>(entityName: "ProductionCountriesData")
    }

    /// Название страны производства
    @NSManaged var name: String?
    @NSManaged var movieInfo: MovieInfoData?
}
