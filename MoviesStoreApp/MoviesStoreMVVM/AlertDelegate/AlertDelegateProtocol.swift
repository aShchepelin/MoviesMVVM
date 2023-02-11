// AlertDelegateProtocol.swift
// Copyright © Aleksandr Shchepelin. All rights reserved.

import Foundation

/// Протокол для универсального алерта
protocol AlertDelegateProtocol: AnyObject {
    func showAlert(error: Error)
}
