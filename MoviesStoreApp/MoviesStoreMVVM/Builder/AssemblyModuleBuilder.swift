// AssemblyModuleBuilder.swift
// Copyright © Aleksandr Shchepelin. All rights reserved.

import UIKit

/// Билдер
final class AssemblyModuleBuilder: AssemblyBuilderProtocol {
    // MARK: - Public Methods

    func makeMovieInfoModel(_ movieID: Int?) -> UIViewController {
        let keyChainService = KeyChainService()
        let view = MovieInfoViewController()
        let moviesAPIService = MoviesAPIService(keyChainService: keyChainService)
        let networkService = NetworkService(moviesAPIService: moviesAPIService)
        let imageService = ImageService()
        let viewModel = MovieInfoViewModel(
            networkService: networkService,
            movieID: movieID ?? 0,
            imageService: imageService
        )
        view.movieInfoViewModel = viewModel
        return view
    }

    func makeMoviesListModel() -> UIViewController {
        let view = MoviesListViewController()
        let keyChainService = KeyChainService()
        let moviesAPIService = MoviesAPIService(keyChainService: keyChainService)
        let networkService = NetworkService(moviesAPIService: moviesAPIService)
        let imageService = ImageService()
        let viewModel = MoviesListViewModel(
            networkService: networkService,
            imageService: imageService,
            moviesAPIService: moviesAPIService,
            keyChainService: keyChainService
        )
        view.moviesListViewModel = viewModel
        return view
    }
}
