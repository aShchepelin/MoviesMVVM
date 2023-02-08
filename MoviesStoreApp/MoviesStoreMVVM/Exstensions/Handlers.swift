// Handlers.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Псевдонимы типа
typealias StrindHandler = ((String) -> Void)?
typealias VoidHandler = () -> ()
typealias IntHandler = (Int) -> (Void)
typealias ErrorHandler = (Error) -> (Void)
