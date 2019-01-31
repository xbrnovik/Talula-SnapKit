//
//  AppDelegate.swift
//  Talula
//
//  Created by Diana Brnovik on 30/01/2019.
//  Copyright © 2019 Diana Brnovik. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var appStarter: AppStarter? = nil
    var sourceDataSync: SourceDataSync? = nil
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Creates master view.
        self.appStarter = AppStarter()
        
        self.sourceDataSync = SourceDataSync()
        self.sourceDataSync?.fetchMeteorites(completion: { (error) in
            //handle error
        })
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        //
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        //
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        //
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        //
    }

    func applicationWillTerminate(_ application: UIApplication) {
        //
    }

}

