//
//  SceneDelegate.swift
//  Talula
//
//  Created by Diana Brnovik on 09/02/2020.
//  Copyright © 2020 Diana Brnovik. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    /// Initializer of views.
    var appStarter: AppStarter?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = scene as? UIWindowScene else {
            return
        }
        self.appStarter = AppStarter(scene)
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.taskScheduler?.scheduleAppRefresh()
    }
}
