/// Copyright (c) 2022 Razeware LLC

import SwiftUI
import CoreData

struct LaunchCreateView: View {
  // MARK: - Environment -
  @Environment(\.dismiss) var dismiss
  // access the keypath to the moc with the Environment Obbject
  @Environment(\.managedObjectContext) var viewContext

  // MARK: - State -
  @State var name: String = ""
  @State var notes: String = ""
  @State var isViewed = false
  @State var launchDate = Date()
  @State var launchpad: String = ""
  @State var tags: String = ""
  
  let launchList: RocketLaunchList

  var body: some View {
    NavigationView {
      Form {
        Section {
          TextField("Title", text: $name)
          TextField("Launch Pad", text: $launchpad)
          TextField("Notes", text: $notes)
        }
        Section {
          TextField("Tags", text: $tags)
        }
        Section {
          DatePicker(selection: $launchDate, displayedComponents: .date) {
            Text("Date")
          }
        }
      }
      .background(Color(.systemGroupedBackground))
      .navigationBarTitle(Text("Create Event"), displayMode: .inline)
      .navigationBarItems(trailing:
        Button(action: {
        let tags = Set(self.tags.split(separator: ",").map {
          Tag.fetchOrCreateWith(title: String($0), in: self.viewContext)
        })
        RocketLaunch.createWith(
          name: self.name,
          notes: self.notes,
          launchDate: self.launchDate,
          isViewed: self.isViewed,
          launchpad: self.launchpad,
          tags: tags,
          in: self.launchList,
          using: self.viewContext)
        dismiss()
        }, label: {
          Text("Save")
            .fontWeight(.bold)
        })
      )
    }
  }
}

struct LaunchCreateView_Previews: PreviewProvider {
  static var previews: some View {
    let context = PersistenceController.preview.container.viewContext
    let newLaunchList = RocketLaunchList(context: context)
    newLaunchList.title = "Preview List"
    return LaunchCreateView(launchList: newLaunchList).environment(\.managedObjectContext, context)
  }
}
