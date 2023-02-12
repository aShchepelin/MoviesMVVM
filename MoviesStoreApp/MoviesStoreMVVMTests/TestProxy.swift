// TestProxy.swift
// Copyright © Aleksandr Shchepelin. All rights reserved.

@testable import MoviesStoreMVVM
import XCTest

/// Текст прокси
final class TestProxy: XCTestCase {
    // MARK: - Constants

    private enum Constants {
        static let mockUrl = "foo"
    }

    // MARK: - Private Properties

    private var proxyService: ProxyProtocol?
    private var mockImageAPIService = MockImageAPIService()
    private var mockFileManagerService = MockFileManagerService()

    // MARK: - Public Methods

    override func setUpWithError() throws {
        proxyService = Proxy(
            imageAPIService: mockImageAPIService,
            fileManagerService: mockFileManagerService
        )
    }

    override func tearDownWithError() throws {
        proxyService = nil
    }

    func testLoadImage() {
        proxyService?.loadImage(url: Constants.mockUrl, completion: { result in
            switch result {
            case let .success(data):
                XCTAssertNotNil(data)
            case let .failure(error):
                XCTAssertNotNil(error)
            }
        })
    }
}
