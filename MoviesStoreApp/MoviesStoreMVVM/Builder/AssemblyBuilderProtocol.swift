// AssemblyBuilderProtocol.swift
// Copyright © Aleksandr Shchepelin. All rights reserved.

import UIKit

/// Протокол билдера
protocol AssemblyBuilderProtocol {
    func makeMovieInfoModel(_ movieID: Int?) -> UIViewController
    func makeMoviesListModel() -> UIViewController
}
