//
//  TimerView.swift
//  EmojiArt
//
//  Created by Alejandro Garcia on 09.01.21.
//  Copyright © 2021 fhnw. All rights reserved.
//

import SwiftUI

struct TimerView: View {
    @ObservedObject var timeCounter = TimeCounter()
    
    var body: some View {
        Text("Zeit: \(timeCounter.time)s")
            .onAppear(){
                //load timer value
                
            }
            .onDisappear(){
                // Save timer value
                UserDefaults.standard.set(timeCounter.time, forKey: "timer")
            }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
