//
//  TimerView.swift
//  EmojiArt
//
//  Created by Alejandro Garcia on 09.01.21.
//  Copyright © 2021 fhnw. All rights reserved.
//

import SwiftUI

struct TimerView: View {
    
    @ObservedObject var timer: TimeCounter
    @State private var cumulatedTime: Int = 0
    
    init(timer: TimeCounter) {
        self.timer = timer
    }

    var body: some View {
        HStack {
            Image(systemName: "clock").imageScale(.large)
            Text("\(cumulatedTime) s")
        }
        .padding()
        
        //load cumulated time if present
        .onAppear {
            self.cumulatedTime = timer.totalUsedTime
        }
        
        //add seconds while working on emojiart
        .onReceive(timer.currentTimePublisher) { time in
            self.cumulatedTime += 1
        }
        
        //safe cumulated time when emojiart closes
        .onDisappear {
            timer.totalUsedTime = cumulatedTime
        }
    }
}
