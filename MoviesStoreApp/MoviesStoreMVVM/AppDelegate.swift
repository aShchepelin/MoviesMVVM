// AppDelegate.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(
        _: UIApplication,
        didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)

        let viewController = MoviesListViewController()
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        return true
    }
}
