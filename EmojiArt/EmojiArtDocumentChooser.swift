import SwiftUI

@available(iOS 14.0, *)
struct EmojiArtDocumentChooser: View {
    @ObservedObject var store: EmojiArtDocumentStore
    @State private var editMode = EditMode.inactive
    @State var isWallOn = false

    var body: some View {
        print(self.editMode)
        return NavigationView {
            List {
                ForEach(self.store.documents) { document in
                    NavigationLink(destination: EmojiArtDocumentView(document: document, opend: false).navigationBarTitle(self.store.name(for: document))) {
                        EditableText(self.store.name(for: document), isEditing: self.editMode.isEditing) { name in
                            self.store.setName(name, for: document)
                        }.accessibility(identifier: "DocumentName")
                    }
                }
                .onDelete(perform: { indexSet in
                    indexSet
                        .map { self.store.documents[$0] }
                        .forEach { document in
                            self.store.removeDocument(document)
                        }
                })
            }.accessibility(identifier: "List")
            .fullScreenCover(isPresented: $isWallOn) {
                EmojiArtWall(store: store, currentView: self)
            }
            .navigationBarTitle(self.store.name)
            .navigationBarItems(
                leading: Button(action: {
                    self.store.addDocument()
                }, label: {
                    Image(systemName: "plus").imageScale(.large)
                }).accessibility(identifier: "AddButton"),
                trailing: HStack {
                    Button(action: {
                        isWallOn = true
                    }, label: {
                        Image(systemName: "rectangle.split.2x2.fill").imageScale(.large)
                    })
                    EditButton().accessibility(identifier: "EditDoneButton")
                }
            )
            .environment(\.editMode, $editMode)
        }
    }
}
