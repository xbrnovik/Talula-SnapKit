//
//  AppStarter.swift
//  Talula
//
//  Created by Diana Brnovik on 30/01/2019.
//  Copyright © 2019 Diana Brnovik. All rights reserved.
//

import Foundation
import UIKit

final class AppStarter {
    
    /// Application window.
    fileprivate var window: UIWindow
    /// NavigationController used in app.
    fileprivate var navigationController: UINavigationController
    /// RootController of app.
    fileprivate var rootViewController: UINavigationController
    
    init(_ windowScene: UIWindowScene) {
        self.rootViewController = UINavigationController()
        navigationController = rootViewController
        // Sets modern navigation bar.
        if #available(iOS 11.0, *) {
            self.navigationController.navigationBar.prefersLargeTitles = true
        }
        // Sets root view.
        self.window = UIWindow(windowScene: windowScene)
        self.window.rootViewController = self.rootViewController
        self.window.makeKeyAndVisible()
        // Shows master.
        showHome()
    }
    
    /// Loads home view, in this case Master module.
    func showHome(){
        let master = MasterViewController()
        master.presentMaster(from: self.navigationController, animated: true)
    }
}
