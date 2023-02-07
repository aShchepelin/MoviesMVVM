// AssemblyBuilderProtocol.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол билдера
protocol AssemblyBuilderProtocol {
    // MARK: - Public Methods

    func makeMovieInfoModel(_ movieID: Int?) -> UIViewController
    func makeMoviesListModel() -> UIViewController
}
