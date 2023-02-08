// AppCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Координатор запуска приложения
final class AppCoordinator: BaseCoordinator {
    // MARK: - Private Properties

    private var assemblyModuleBuilder: AssemblyBuilderProtocol?

    // MARK: - Init

    init(assemblyModeleBuilder: AssemblyBuilderProtocol) {
        assemblyModuleBuilder = assemblyModeleBuilder
    }

    // MARK: - Public Methods

    override func start() {
        guard let assemblyModuleBuilder = assemblyModuleBuilder else { return }
        toMovieList(assemblyModuleBuilder: assemblyModuleBuilder)
    }

    // MARK: - Private Methods

    private func toMovieList(assemblyModuleBuilder: AssemblyBuilderProtocol) {
        let coordinator = MoviesCoordinator(assemblyModuleBuilder: assemblyModuleBuilder)
        addDependency(coordinator)
        coordinator.start()
    }
}
