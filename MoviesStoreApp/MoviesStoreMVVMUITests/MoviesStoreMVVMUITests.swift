// MoviesStoreMVVMUITests.swift
// Copyright © Aleksandr Shchepelin. All rights reserved.

import XCTest

/// Тест интерфейса приложения
final class MoviesStoreMVVMUITests: XCTestCase {
    // MARK: - Private Enum

    private enum Constants {
        static let topMovies = "Топ Фильмов"
        static let movieIdentifier = "Моя пиратская свадьба"
        static let navigationBar = "MoviesStoreMVVM.MovieInfoView"
        static let backButtonTitle = "Back"
        static let voteAverage = "8.8"
        static let cellIdentfier = "6.5"
        static let popularSegmentName = "Популярные"
        static let soonSegmentName = "Скоро"
    }

    // MARK: - Public Methods

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {}

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()

        app.buttons[Constants.topMovies].tap()

        let tablesQuery = app.tables
        tablesQuery.cells.containing(.staticText, identifier: Constants.voteAverage).element.tap()

        let backButton = app.navigationBars[Constants.navigationBar].buttons[Constants.backButtonTitle]
        backButton.tap()
        app.buttons[Constants.soonSegmentName].tap()
        tablesQuery.cells.containing(.staticText, identifier: Constants.cellIdentfier).element.tap()
        backButton.tap()
        app.buttons[Constants.popularSegmentName].tap()
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
