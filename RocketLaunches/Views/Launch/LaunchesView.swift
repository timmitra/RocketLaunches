/// Copyright (c) 2022 Razeware LLC

import SwiftUI

struct LaunchesView: View {
  @State var isShowingCreateModal = false
  let launchesFetchRequest = RocketLaunch.unViewedLaunchesFetchRequest()
  var launches: FetchedResults<RocketLaunch> {
    // wrapped value makes it easier to access values
    launchesFetchRequest.wrappedValue
  }
  
  let sortTypes = [
    (name: "Name", descriptors: [SortDescriptor(\RocketLaunch.name, order: .forward)]),
    (name: "LaunchDate", descriptors: [SortDescriptor(\RocketLaunch.launchDate, order: .forward)])
  ]
  
  @State var activeSortIndex = 0
  
  var body: some View {
    VStack {
      List {
        Section {
          ForEach(launches, id: \.self) { launch in
            HStack {
              NavigationLink(destination: LaunchDetailView(launch: launch)) {
                LaunchStatusView(isViewed: launch.isViewed)
                Text("\(launch.name ?? "")")
              }
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
    .onChange(of: activeSortIndex) { _ in
      launches.sortDescriptors = sortTypes[activeSortIndex].descriptors
    }
    .toolbar {
          Menu(content: {
            Picker(
              selection: $activeSortIndex,
              content: {
                ForEach(0..<sortTypes.count, id: \.self) { index in
                  let sortType = sortTypes[index]
                  Text(sortType.name)
                }
              },
              label: {}
            )
          }, label: {
            Image(systemName: "line.3.horizontal.decrease.circle.fill")
          })
        }
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
