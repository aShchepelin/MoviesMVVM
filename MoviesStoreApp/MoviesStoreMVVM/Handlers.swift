// Handlers.swift
// Copyright © Aleksandr Shchepelin. All rights reserved.

import Foundation

/// Псевдонимы типа
typealias StrindHandler = ((String) -> Void)?
typealias IntHandler = (Int) -> (Void)
typealias ErrorHandler = (Error) -> (Void)
typealias CoreDataHandler = (String) -> (Void)
// swiftlint:disable all
typealias VoidHandler = () -> Void
// swiftlint:enable all
