/// Copyright (c) 2022 Razeware LLC


import SwiftUI
import CoreData

struct ContentView: View {
  @State var isShowingListModal = false

  var body: some View {
    NavigationView {
      //LaunchesView()
      ListView()
        .navigationBarTitle(Text("Launches"))
        .navigationBarItems(
                  trailing:
                    HStack {
                      Button(
                        action: { self.isShowingListModal.toggle() },
                        label: { Image(systemName: "plus") }
                      )
                      Button(
                        action: {
                          Task {
                            try await PersistenceController.fetchSpaceXLaunches()
                          }
                        },
                        label: { Image(systemName: "arrow.clockwise") }
                      )
                    }
                    .sheet(isPresented: $isShowingListModal) {
                      ListCreateView(text: "")
                    }
                )
        //.navigationBarItems(leading: EditButton())
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
