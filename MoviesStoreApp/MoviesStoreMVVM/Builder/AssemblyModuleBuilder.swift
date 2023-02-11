// AssemblyModuleBuilder.swift
// Copyright © Aleksandr Shchepelin. All rights reserved.

import UIKit

/// Билдер
final class AssemblyModuleBuilder: AssemblyBuilderProtocol {
    // MARK: - Public Methods

    func makeMovieInfoModel(_ movieID: Int?) -> UIViewController {
        let keyChainService = KeyChainService()
        let view = MovieInfoViewController()
        let fileManagerService = FileManagerService()
        let imageAPIService = ImageAPIService()
        let proxy = Proxy(imageAPIService: imageAPIService, fileManagerService: fileManagerService)
        let moviesAPIService = MoviesAPIService(keyChainService: keyChainService)
        let coreDataService = CoreDataService(modelName: CoreDataConstants.movieDataModel)
        let networkService = NetworkService(moviesAPIService: moviesAPIService)
        let imageService = ImageService(proxy: proxy)
        let viewModel = MovieInfoViewModel(
            networkService: networkService,
            movieID: movieID ?? 0,
            imageService: imageService,
            coreDataService: coreDataService
        )
        view.movieInfoViewModel = viewModel
        return view
    }

    func makeMoviesListModel() -> UIViewController {
        let view = MoviesListViewController()
        let keyChainService = KeyChainService()
        let fileManagerService = FileManagerService()
        let imageAPIService = ImageAPIService()
        let proxy = Proxy(imageAPIService: imageAPIService, fileManagerService: fileManagerService)
        let coreDataService = CoreDataService(modelName: CoreDataConstants.movieDataModel)
        let moviesAPIService = MoviesAPIService(keyChainService: keyChainService)
        let networkService = NetworkService(moviesAPIService: moviesAPIService)
        let imageService = ImageService(proxy: proxy)
        let viewModel = MoviesListViewModel(
            networkService: networkService,
            imageService: imageService,
            moviesAPIService: moviesAPIService,
            keyChainService: keyChainService,
            coreDataService: coreDataService
        )
        view.moviesListViewModel = viewModel
        return view
    }
}
