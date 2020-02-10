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
    /// Manager of data downloads tasks.
    var taskScheduler: TaskScheduler?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.taskScheduler = TaskScheduler()
        self.taskScheduler?.foregroundRun()
        self.taskScheduler?.registerTask()
        return true
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        self.taskScheduler?.foregroundRun()
    }
}
