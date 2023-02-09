// AppDelegate.swift
// Copyright © Aleksandr Shchepelin. All rights reserved.

import CoreData
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    // MARK: - Core Data stack

    lazy var coreDataStack: CoreDataService = .init(modelName: CoreDataConstants.movieDataModel)

    static let sharedAppDelegate: AppDelegate = {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError(
                "\(String(describing: UIApplication.shared.delegate))"
            )
        }
        return delegate
    }()
}
