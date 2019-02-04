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
    fileprivate let window: UIWindow = UIWindow(frame: UIScreen.main.bounds)
    /// NavigationController used in app.
    fileprivate var navigationController: UINavigationController
    /// RootController of app.
    fileprivate var rootViewController: UINavigationController
    
    init() {
        self.rootViewController = UINavigationController()
        navigationController = rootViewController
        // Sets modern navigation bar.
        if #available(iOS 11.0, *) {
            self.navigationController.navigationBar.prefersLargeTitles = true
        }
        
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
