//
//  ScheduledTaskManager.swift
//  ISS Position
//
//  Created by Marcin Kuswik on 13.09.2018.
//  Copyright © 2018 Marcin Kuświk. All rights reserved.
//

import Foundation

protocol ScheduledTaskDelegate: class {
    
    func performTask()
    
}

class ScheduledTaskManager {
    
    let interval: Double
    
    let repeats: Bool
    
    var isStoped: Bool = false
    
    weak var delegate: ScheduledTaskDelegate?
    
    init(interval: Double, repeats: Bool, delegate: ScheduledTaskDelegate) {
        self.interval = interval
        self.repeats = repeats
        self.delegate = delegate
    }
    
    func start() {
        isStoped = false
        Timer.scheduledTimer(withTimeInterval: interval, repeats: repeats, block: { (timer) in
            self.delegate?.performTask()
            
            if self.isStoped {
                timer.invalidate()
            }
        })
    }
    
    func stop() {
        isStoped = true
    }
    
    deinit {
        isStoped = true
    }
}
