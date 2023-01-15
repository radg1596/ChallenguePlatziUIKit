//
//  AlertViewManager.swift
//  ChallenguePlatziUIKit
//
//  Created by Ricardo Desiderio on 14/01/23.
//

import UIKit

final class AlertViewManager {

    // MARK: - METHODS
    func showSimpleRetryAlert(view: UIViewController,
                              title: String,
                              message: String,
                              retryTitle: String,
                              retryCompletion: (() -> Void)?) {
        let alertViewController = UIAlertController(title: title,
                                                    message: message,
                                                    preferredStyle: .alert)
        let retryButton = UIAlertAction(title: retryTitle,
                                     style: .default) { _ in
            alertViewController.dismiss(animated: true) {
                retryCompletion?()
            }
        }
        alertViewController.addAction(retryButton)
        view.present(alertViewController,
                     animated: true)
    }

}
