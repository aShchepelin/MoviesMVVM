// MockKeyChainService.swift
// Copyright © Aleksandr Shchepelin. All rights reserved.

import Foundation
@testable import MoviesStoreMVVM

/// Мок сервиса по сохранению API
final class MockKeyChainService: KeyChainServiceProtocol {
    // MARK: - Public Properties

    func setValue(_ value: String, forKey: String) {}

    func getValue(_ key: String) -> String {
        UnitTest.foo
    }
}
