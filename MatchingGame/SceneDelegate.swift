//
//  SceneDelegate.swift
//  MatchingGame
//
//  Created by Thành Đỗ Long on 11/01/2020.
//  Copyright © 2020 Thành Đỗ Long. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    public lazy var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
    public lazy var appDependency = AppDependency()
    public lazy var homeCoordinator = HomeCoordinator(router: router, container: appDependency.container)
    public lazy var router = AppDelegateRouter(window: window!)

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            window?.windowScene = windowScene
            homeCoordinator.present(animated: true, onDismissed: nil)
        }
    }
}
