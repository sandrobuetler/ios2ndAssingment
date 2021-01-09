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
    @Published var time = 0
    
    lazy var timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in self.time += 1 }
    init() { timer.fire() }
}
