//
//  TaskScheduler.swift
//  Talula
//
//  Created by Diana Brnovik on 09/02/2020.
//  Copyright © 2020 Diana Brnovik. All rights reserved.
//

import Foundation
import BackgroundTasks

class TaskScheduler {
    
    /// Synchronizer of downloaded data.
    private var dataSync: DataSync = DataSync()
    
    /// Registrates app refresh task. (App assumes small amount of data and uses BGAppRefreshTask. For larger amount of data BGProcessingTaskRequest would be more suitable.)
    func registerTask() {
        BGTaskScheduler.shared.register(forTaskWithIdentifier: Constants.dataSync.taskName, using: nil) { [weak self] task in
            guard let task = task as? BGAppRefreshTask else {
                NSLog("Task is not type of BGAppRefreshTask")
                return
            }
            self?.handleAppRefresh(task)
        }
    }
    
    /// Schedules next call of background app refresh task.
    func scheduleAppRefresh() {
        let request = BGAppRefreshTaskRequest(identifier: Constants.dataSync.taskName)
        request.earliestBeginDate = Date(timeIntervalSinceNow: TimeInterval(Constants.dataSync.updateDelay))
        do {
            try BGTaskScheduler.shared.submit(request)
        } catch {
            NSLog("Could not schedule app refresh: \(error)")
        }
    }
    
    /// Runs foreground download and sync.
    func foregroundRun() {
        dataSync.foregroundRun()
    }
    
    /**
    Runs background download and sync as operation.
    
    - Parameter task: Refresh registrated task.
    */
    private func handleAppRefresh(_ task: BGAppRefreshTask) {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        let dataRefreshOperation = DataRefreshOperation(dataSync: dataSync)
        task.expirationHandler = {
            dataRefreshOperation.cancel()
            // queue.cancelAllOperations() - Alternatively.
        }
        dataRefreshOperation.completionBlock = {
            task.setTaskCompleted(success: dataRefreshOperation.isCancelled)
        }
        queue.addOperation(dataRefreshOperation)
        scheduleAppRefresh()
    }
}
