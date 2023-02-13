// TestMovieInfoViewModel.swift
// Copyright © Aleksandr Shchepelin. All rights reserved.

@testable import MoviesStoreMVVM
import XCTest

/// Тест экрана с подробной информацией о фильме
final class TestMovieInfoViewModel: XCTestCase {
    // MARK: - Private Properties

    private var movieID = 0
    private var movieInfo: MovieInfo?
    private var keychainService = MockKeyChainService()
    private var imageService = MockImageService()
    private var coreDataService = MockCoreDataService()
    private var networkService = MockNetworkService()
    private var movieAPIService = MockMoviesAPIService()
    private var movieInfoViewModel: MovieInfoViewModelProtocol?

    // MARK: - Public Methods

    override func setUp() {
        super.setUp()
        movieInfoViewModel = MovieInfoViewModel(
            networkService: networkService,
            movieID: movieID,
            imageService: imageService,
            coreDataService: coreDataService
        )
    }

    func testFetchImage() {
        movieInfoViewModel?.fetchImage(url: UnitTest.foo, completion: { result in
            switch result {
            case let .success(data):
                XCTAssertEqual(data, UnitTest.foo.data(using: .utf8))
            case let .failure(error):
                print(error)
            }
        })
    }

    func testLoadMovieInfo() {
        XCTAssertNoThrow(movieInfoViewModel?.loadMovieInfo())
    }
}
