/// Copyright (c) 2022 Razeware LLC

import SwiftUI

struct LaunchesView: View {
  @State var isShowingCreateModal = false
  let launchesFetchRequest = RocketLaunch.fetchRequestSortedByNameAndLaunchDate()
  var launches: FetchedResults<RocketLaunch> {
    // wrapped value makes it easier to access values
    launchesFetchRequest.wrappedValue
  }
  
  var body: some View {
    VStack {
      List {
        Section {
          ForEach(launches, id: \.self) { launch in
            HStack {
              LaunchStatusView(isViewed: launch.isViewed)
              Text("\(launch.name ?? "")")
            }
          }
        }
      }
      .background(Color.white)
      HStack {
        NewLaunchButton(isShowingCreateModal: $isShowingCreateModal)
        Spacer()
      }
      .padding(.leading)
    }
    .navigationBarTitle(Text("Launches"))
  }
}

struct LaunchesView_Previews: PreviewProvider {
  static var previews: some View {
    let context = PersistenceContoller.preview.container.viewContext
    let newLaunch = RocketLaunch(context: context)
    newLaunch.name = "A really cool launch"
    return LaunchesView()
  }
}

struct NewLaunchButton: View {
  @Binding var isShowingCreateModal: Bool

  var body: some View {
    Button(
      action: { self.isShowingCreateModal.toggle() },
      label: {
        Image(systemName: "plus.circle.fill")
          .foregroundColor(.red)
        Text("New Launch")
          .font(.headline)
          .foregroundColor(.red)
      })
      .sheet(isPresented: $isShowingCreateModal) {
        LaunchCreateView()
      }
  }
}
