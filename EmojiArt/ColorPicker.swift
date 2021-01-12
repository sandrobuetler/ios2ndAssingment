//
//  ColorPicker.swift
//  EmojiArt
//
//  Created by Sandro Bütler on 12.01.21.
//  Copyright © 2021 fhnw. All rights reserved.
//

import SwiftUI


struct ColorPicker: View {
    @ObservedObject var document: EmojiArtDocument
    @State var chosenColor: Color = Color.white
    @Binding var backgroundColor: Color
    
    var body: some View {
        VStack {
            if #available(iOS 14.0, *) {
                ColorPicker("" , selection: $chosenColor).onChange(of: chosenColor, perform: { color in document.backgroundColor = color
                    print(color)
                })
            } else {
                Text("Color picking is only available on iOS 14+")
            }
        }
    }
}
