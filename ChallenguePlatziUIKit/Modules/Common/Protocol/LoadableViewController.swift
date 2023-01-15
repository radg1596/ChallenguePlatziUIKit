//
//  LoadableViewController.swift
//  ChallenguePlatziUIKit
//
//  Created by Ricardo Desiderio on 14/01/23.
//

import UIKit

/**
 Abstract:
 Loadable protocol for show a loading UI interface that uses the entire screen
 Usually will use this method in a UIViewController
 If the class conforms this protocol, can use the loadable controller
 */
protocol LoadableViewController: AnyObject {
    /// References the current loading controller in the screen
    var currentLoadingViewController: LoadingViewController? { get set }
    /// Shows the loader, and call the completion after presented
    /// - Parameter completion: Completion to call after present
    func showLoading(completion: (() -> Void)?)
    /// Hides the curren loading controller. If currently not loading, completion will not be called
    /// - Parameter completion: Completion to call after dismiss
    func hideLoading(completion: (() -> Void)?)
}

/// Implements the protocol when Self is a ViewController
extension LoadableViewController where Self: UIViewController {

    var currentLoadingViewController: LoadingViewController? { return nil }

    func showLoading(completion: (() -> Void)?) {
        let loadingViewController: LoadingViewController = LoadingViewController()
        loadingViewController.modalPresentationStyle = .overCurrentContext
        loadingViewController.modalTransitionStyle = .crossDissolve
        currentLoadingViewController = loadingViewController
        present(loadingViewController, animated: true,
                completion: completion)
    }

    func hideLoading(completion: (() -> Void)?) {
        if let currentLoadingViewController = currentLoadingViewController {
            currentLoadingViewController.dismiss(animated: true,
                                                 completion: completion)
            self.currentLoadingViewController = nil
        }
    }

}
