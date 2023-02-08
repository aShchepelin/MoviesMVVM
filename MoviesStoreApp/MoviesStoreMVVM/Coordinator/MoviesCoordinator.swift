// MoviesCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор флоу фильмов
final class MoviesCoordinator: BaseCoordinator {
    // MARK: - Private Visual Components

    private var rootController: UINavigationController?

    // MARK: - Private Properties

    private var onMovieInfoModule: IntHandler?
    private var assemblyModuleBuilder: AssemblyBuilderProtocol?

    // MARK: - Init

    init(assemblyModuleBuilder: AssemblyBuilderProtocol) {
        self.assemblyModuleBuilder = assemblyModuleBuilder
    }

    // MARK: - Public Methods

    override func start() {
        showMovieListModule()
    }

    // MARK: - Private Methods

    private func showMovieListModule() {
        guard let controller = assemblyModuleBuilder?.makeMoviesListModel() as? MoviesListViewController else { return }
        controller.onMovieInfoModule = { [weak self] movieID in
            self?.showMovieInfoModule(movieID)
        }
        let rootController = UINavigationController(rootViewController: controller)
        setAsRoot(rootController)
        self.rootController = rootController
    }

    private func showMovieInfoModule(_ movieID: Int) {
        guard let controller = assemblyModuleBuilder?.makeMovieInfoModel(movieID) as? MovieInfoViewController
        else { return }
        rootController?.pushViewController(
            controller,
            animated: true
        )
    }
}
