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
    
    fileprivate let window: UIWindow = UIWindow(frame: UIScreen.main.bounds)
    
    fileprivate var navigationController: UINavigationController
    fileprivate var rootViewController: UINavigationController
    
    init(){
        self.rootViewController = UINavigationController()
        navigationController = rootViewController
        
        self.window.rootViewController = self.rootViewController
        self.window.makeKeyAndVisible()
        
        showHome()
    }
    
    func showHome(){
        let master = MasterViewController()
        master.presentMaster(from: self.navigationController, animated: true)
    }
}
