/// Copyright (c) 2022 Razeware LLC

import SwiftUI

struct LaunchCreateView: View {
  // MARK: - Environment -
  @Environment(\.dismiss) var dismiss

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
