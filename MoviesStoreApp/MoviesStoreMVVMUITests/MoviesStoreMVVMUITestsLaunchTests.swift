// MoviesStoreMVVMUITestsLaunchTests.swift
// Copyright © Aleksandr Shchepelin. All rights reserved.

import XCTest

/// Тест работы интерфейса при запуске приложения
final class MoviesStoreMVVMUITestsLaunchTests: XCTestCase {
    // MARK: - Private Enum

    private enum Constants {
        static let launchScreen = "Launch Screen"
    }

    // MARK: - Public Properties

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    // MARK: - Public Methods

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()
        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = Constants.launchScreen
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
