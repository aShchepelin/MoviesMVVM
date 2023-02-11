// SceneDelegate.swift
// Copyright © Aleksandr Shchepelin. All rights reserved.

import UIKit

/// SceneDelegate
final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var coordinator: AppCoordinator?
    var window: UIWindow?
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.makeKeyAndVisible()
        let assemblyModelBuilder = AssemblyModuleBuilder()
        coordinator = AppCoordinator(assemblyModeleBuilder: assemblyModelBuilder)
        coordinator?.start()
    }
}
