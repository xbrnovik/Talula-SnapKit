//
//  DataRefreshOperation.swift
//  Talula
//
//  Created by Diana Brnovik on 09/02/2020.
//  Copyright © 2020 Diana Brnovik. All rights reserved.
//

import Foundation

class DataRefreshOperation: Operation {
    
    let dataSync: DataSync
    
    init(dataSync: DataSync) {
        self.dataSync = dataSync
        super.init()
    }
}

extension DataRefreshOperation {
    
    override func main() {
        dataSync.backgroundRun()
    }
    
    override func start() {
        guard !isCancelled else {
            return
        }
        main()
    }
}
