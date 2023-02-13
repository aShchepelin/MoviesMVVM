// BaseCoordinator.swift
// Copyright © Aleksandr Shchepelin. All rights reserved.

import UIKit

/// Главный координатор
class BaseCoordinator {
    // MARK: - Private Properties

    private var childCoordinators: [BaseCoordinator] = []

    // MARK: - Public Methods

    func start() {}

    func addDependency(_ coordinator: BaseCoordinator) {
        for element in childCoordinators where element === coordinator {
            return
        }
        childCoordinators.append(coordinator)
    }

    func setAsRoot(_ controller: UIViewController) {
        if #available(iOS 13, *) {
            let sceneDelegate =
                UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
            sceneDelegate?.window?.rootViewController = controller
        } else {
            UIApplication.shared.keyWindow?.rootViewController = controller
        }
    }
}
