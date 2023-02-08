// KeyChainService.swift
// Copyright © Aleksandr Shchepelin. All rights reserved.

import KeychainSwift

/// Сервис сохранения APIKey
struct KeyChainService: KeyChainServiceProtocol {
    // MARK: - Private properties

    private let keychain = KeychainSwift()

    // MARK: - Public Methods

    func setValue(_ value: String, forKey: String) {
        keychain.set(value, forKey: forKey)
    }

    func getValue(_ key: String) -> String {
        guard let keyValue = keychain.get(key) else { return String() }
        return keyValue
    }
}
