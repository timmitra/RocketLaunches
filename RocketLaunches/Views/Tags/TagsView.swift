/// Copyright (c) 2022 Razeware LLC

import SwiftUI

struct TagsView: View {
  // access the keypath to the moc with the Environment Object
  @Environment(\.managedObjectContext) var viewContext
  let tags: [Tag]
  
    var body: some View {
      NavigationView {
        VStack {
          List {
            Section {
              ForEach(tags, id: \.self) { tag in
                Text("\(tag.title!) (\(tag.launchCount))")
              }
            }
          }
        }
      }
      .navigationTitle(Text("Tags"))
    }
}

struct TagsView_Previews: PreviewProvider {
    static var previews: some View {
      let context = PersistenceContoller.preview.container.viewContext
      let tag = Tag(context: context)
      tag.title = "preview tag"
      return TagsView(tags:[tag])
    }
}
