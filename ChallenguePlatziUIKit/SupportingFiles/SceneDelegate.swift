//
//  SceneDelegate.swift
//  ChallenguePlatziUIKit
//
//  Created by Ricardo Desiderio on 12/01/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        configureRootViewController(scene: scene)
        setCacheSizeForURLSession()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }

    // MARK: - OWN METHODS
    private func configureRootViewController(scene: UIScene) {
        guard let windowsScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowsScene)
        let rootViewController = CatsPrincipalLandingView()
        let navigationController = UINavigationController(rootViewController: rootViewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

    private func setCacheSizeForURLSession() {
        URLCache.shared.memoryCapacity = 250 * 1024 * 1024
        URLCache.shared.diskCapacity = 1024 * 1024 * 1024
    }

}

