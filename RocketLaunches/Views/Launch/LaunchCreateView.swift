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

  var body: some View {
    NavigationView {
      Form {
        Section {
          TextField("Title", text: $name)
          TextField("Launch Pad", text: $launchpad)
          TextField("Notes", text: $notes)
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
          // use the moc viewContext to create instance of RocketLaunch
          let launch = RocketLaunch(context: self.viewContext)
          // can now set values and the context will keep track
          launch.name = self.text
          launch.notes = self.notes
          launch.launchpad = self.launchpad
          launch.isViewed = self.isViewed
          launch.launchDate = self.launchDate
        do {
          try self.viewContext.save()
        } catch {
          let nserror = error as NSError
          fatalError("Unresolved Error \(nserror), \(nserror.userInfo)")
        }
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
    LaunchCreateView()
  }
}
