//
//  SceneDelegate.swift
//  MoneyPlus
//
//  Created by FakeCoder on 2020/10/10.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let rootVC = ViewController()
        rootVC.title = "Personal Finance"
        let rootNavVC = UINavigationController(rootViewController: rootVC)
        self.window?.rootViewController = rootNavVC
    }

}

