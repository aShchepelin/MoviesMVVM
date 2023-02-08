// MoviesListStates.swift
// Copyright © Aleksandr Shchepelin. All rights reserved.

import Foundation

/// Состояния экрана списка фильмов
enum MoviesListStates {
    case initial
    case success
    case failure(Error)
}
