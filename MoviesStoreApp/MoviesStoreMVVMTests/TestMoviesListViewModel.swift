// TestMoviesListViewModel.swift
// Copyright © Aleksandr Shchepelin. All rights reserved.

@testable import MoviesStoreMVVM
import XCTest

/// Тест экрана со списком фильмов + network service
final class TestMoviesListViewModel: XCTestCase {
    // MARK: - Private Properties

    private var movies: [Movie] = []
    private var movieInfo: MovieInfo?
    private var keychainService = MockKeyChainService()
    private var imageService = MockImageService()
    private var coreDataService = MockCoreDataService()
    private var networkService = MockNetworkService()
    private var moviesListViewModel: MoviesListViewModelProtocol?
    private var movieAPIService = MockMoviesAPIService()
    private var movieCategory: MovieCategory = .popular

    // MARK: - Public Methods

    override func setUp() {
        moviesListViewModel = MoviesListViewModel(
            networkService: networkService,
            imageService: imageService,
            moviesAPIService: movieAPIService,
            keyChainService: keychainService,
            coreDataService: coreDataService
        )
    }

    func testFetchMovies() {
        networkService.fetchMovies(moviesType: URLRequest.popularRequest) { [weak self] mockResult in
            guard let self = self else { return }
            switch mockResult {
            case let .success(success):
                self.movies = success
                XCTAssertEqual(self.movies.count, 20)
            case let .failure(failure):
                XCTAssertNotNil(failure)
            }
        }
    }

    func testKeyCheyInfo() {
        XCTAssertNoThrow(moviesListViewModel?.keyChainInfo())
    }

    func testKeyChainSetValue() {
        let mockValue = UnitTest.foo
        keychainService.setValue(mockValue, forKey: UnitTest.keyChainForKey)
        let catchMockValue = keychainService.getValue(UnitTest.keyChainForKey)
        XCTAssertNotNil(catchMockValue)
        XCTAssertEqual(mockValue, catchMockValue)
    }

    func testFetchMovieInfo() {
        networkService.fetchMovieInfo(movieID: 1) { [weak self] mockResult in
            guard let self = self else { return }
            switch mockResult {
            case let .success(success):
                self.movieInfo = success
                XCTAssertNotNil(self.movieInfo)
            case let .failure(failure):
                XCTAssertNotNil(failure)
            }
        }
    }

    func testFetchImage() {
        moviesListViewModel?.fetchImage(url: UnitTest.foo, completion: { result in
            switch result {
            case let .success(data):
                XCTAssertEqual(data, UnitTest.foo.data(using: .utf8))
            case let .failure(error):
                XCTAssertNotNil(error)
            }
        })
    }

    func testFetchMovieCategory() {
        moviesListViewModel?.fetchTypeMovies(index: 0)
        XCTAssertEqual(moviesListViewModel?.movieCategory, .topRated)
        moviesListViewModel?.fetchTypeMovies(index: 1)
        XCTAssertEqual(moviesListViewModel?.movieCategory, .popular)
        moviesListViewModel?.fetchTypeMovies(index: 2)
        XCTAssertEqual(moviesListViewModel?.movieCategory, .upcoming)
        moviesListViewModel?.fetchTypeMovies(index: 3)
    }
}
