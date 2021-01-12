//
//  EmojiArtWall.swift
//  EmojiArt
//
//  Created by Sandro Bütler on 12.01.21.
//  Copyright © 2021 fhnw. All rights reserved.
//

import SwiftUI

@available(iOS 14.0, *)
struct EmojiArtWall: View {
    
    @ObservedObject var store: EmojiArtDocumentStore
    @Binding private var isPresented: Bool?
    
    init(store: EmojiArtDocumentStore, currentView: EmojiArtDocumentChooser) {
        self.store = store
        self._isPresented = Binding.init(currentView.$isWallOn)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Button(action: {
                    isPresented = false
                }, label: {
                    Image(systemName: "list.dash").imageScale(.large)
                })
                Grid(store.documents, id: \.self) {document in
                    NavigationLink(destination: EmojiArtDocumentView(document:document, opend: false)) {
                        VStack {
                            Text(store.name(for: document))
                            EmojiArtDocumentView(document: document, opend: true)
                        }.navigationBarHidden(true)
                        .padding()
                    }
                }
            }
        }
    }
}
