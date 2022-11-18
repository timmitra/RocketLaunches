/// Copyright (c) 2022 Razeware LLC


import SwiftUI
import CoreData

struct ContentView: View {
  @State var isShowingListModal = false

  var body: some View {
    NavigationView {
      LaunchesView()
        .navigationBarTitle(Text("Launches"))
        .navigationBarItems(leading: EditButton())
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
