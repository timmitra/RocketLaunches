/// Copyright (c) 2022 Razeware LLC

import SwiftUI

struct LaunchesView: View {
  @State var isShowingCreateModal = false
  let launchesFetchRequest: FetchRequest<RocketLaunch>
  var launches: FetchedResults<RocketLaunch> {
    // wrapped value makes it easier to access values
    launchesFetchRequest.wrappedValue
  }
  
  let launchList: RocketLaunchList
  
  let sortTypes = [
    (name: "Name", descriptors: [SortDescriptor(\RocketLaunch.name, order: .forward)]),
    (name: "LaunchDate", descriptors: [SortDescriptor(\RocketLaunch.launchDate, order: .forward)])
  ]
  
  @State var activeSortIndex = 0
  @State var isShowingTagsModal: Bool = false
  var tags: Array<Tag> {
    // compactMap because tag is optional
    // reduce to convert Array to Set of uniques
    let tagsSet = launchList.launches?.compactMap({$0.tags}).reduce(Set<Tag>(), { result, tags in
      var result = result
      result.formUnion(tags)
      return result
    })
    return Array(tagsSet!)
  }
  
  init(launchList: RocketLaunchList) {
    self.launchList = launchList
    self.launchesFetchRequest = RocketLaunch.launches(in: launchList)
  }
  
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
        NewLaunchButton(isShowingCreateModal: $isShowingCreateModal, launchList: self.launchList)
        Spacer()
      }
      .padding(.leading)
    }
    .navigationBarTitle(Text("Launches"))
    .onChange(of: activeSortIndex) { _ in
      launches.sortDescriptors = sortTypes[activeSortIndex].descriptors
    }
    .navigationBarItems(trailing:
                          Button(action: { self.isShowingTagsModal.toggle() }) {
      Text("tags")
    }.sheet(isPresented: self.$isShowingTagsModal, content: {
      TagsView(tags: self.tags)
    })
    )
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
    let context = PersistenceController.preview.container.viewContext
    //let newLaunch = RocketLaunch(context: context)
    //newLaunch.name = "A really cool launch"
    let newLaunchList = RocketLaunchList(context: context)
    newLaunchList.title = "Preview List"
    return LaunchesView(launchList: newLaunchList).environment(\.managedObjectContext, context)
  }
}

struct NewLaunchButton: View {
  @Binding var isShowingCreateModal: Bool
  let launchList: RocketLaunchList

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
        LaunchCreateView(launchList: launchList)
      }
  }
}
