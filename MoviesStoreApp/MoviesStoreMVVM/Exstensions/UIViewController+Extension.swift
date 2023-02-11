// UIViewController+Extension.swift
// Copyright © Aleksandr Shchepelin. All rights reserved.

import UIKit

/// Универсальные алерты
extension UIViewController {
    func showAlert(
        title: String?,
        message: String?,
        actionTitle: String?,
        handler: ((UIAlertAction) -> ())?
    ) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let alertControllerAction = UIAlertAction(
            title: actionTitle,
            style: .default,
            handler: handler
        )
        alertController.addAction(alertControllerAction)
        present(alertController, animated: true)
    }

    func showKeyChainAlert(
        title: String?,
        message: String?,
        actionTitle: String?,
        handler: StrindHandler
    ) {
        let keyChainAlertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let keyChainAlertControllerAction = UIAlertAction(
            title: actionTitle,
            style: .default
        ) { _ in
            let result = keyChainAlertController.textFields?.first?.text ?? ""
            handler?(result)
        }
        keyChainAlertController.addTextField()
        keyChainAlertController.addAction(keyChainAlertControllerAction)
        present(keyChainAlertController, animated: true)
    }
}
