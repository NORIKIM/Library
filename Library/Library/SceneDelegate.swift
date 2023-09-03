//
//  SceneDelegate.swift
//  Library
//
//  Created by 김지나 on 2023/09/03.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let navi = storyboard.instantiateViewController(withIdentifier: "Navi") as? UINavigationController {
            coordinator = AppCoordinator(navi: navi)
            coordinator?.start()
            
            if let windowScene = scene as? UIWindowScene {
                let window = UIWindow(windowScene: windowScene)
                window.rootViewController = navi
                self.window = window
                window.makeKeyAndVisible()
            }
        }
    }
}

