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

    var appStarter: AppStarter?
    var dataSync: DataSync?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Creates master view.
        self.appStarter = AppStarter()
        // Starts data download if necessary.
        self.dataSync = DataSync()
        //On the first launch is not called "applicationWillEnterForeground".
        self.dataSync?.foregroundRun()
        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        application.setMinimumBackgroundFetchInterval(UIApplication.backgroundFetchIntervalMinimum)
    }
    
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        self.dataSync?.backgroundRun(completionHandler)
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        self.dataSync?.foregroundRun()
    }

}
