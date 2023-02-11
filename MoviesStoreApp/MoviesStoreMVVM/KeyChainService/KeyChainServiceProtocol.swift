// KeyChainServiceProtocol.swift
// Copyright © Aleksandr Shchepelin. All rights reserved.

import Foundation

/// Протокол сервиса для хранения критических данных
protocol KeyChainServiceProtocol {
    func setValue(_ value: String, forKey: String)
    func getValue(_ key: String) -> String
}
