//
//  TimeCounter.swift
//  EmojiArt
//
//  Created by Alejandro Garcia on 09.01.21.
//  Copyright © 2021 fhnw. All rights reserved.
//

import Foundation
import Combine

class TimeCounter: ObservableObject {
    let currentTimePublisher = Timer.TimerPublisher(interval: 1.0, runLoop: .main, mode: .default)
    let cancellable: AnyCancellable?
    
    var totalUsedTime: Int = 0

    init(totalUsedTime: Int) {
        self.cancellable = currentTimePublisher.connect() as? AnyCancellable
        self.totalUsedTime = totalUsedTime
    }

    deinit {
        self.cancellable?.cancel()
    }
}
