/// Copyright (c) 2022 Razeware LLC

import SwiftUI

struct ListView: View {
  
  @FetchRequest(sortDescriptors: [])
  var launchLists: FetchedResults<RocketLaunchList>
  
  @FetchRequest(sortDescriptors: [], animation: .default)
  var spaceXLaunchLists: FetchedResults<SpaceXLaunchList>
  
  var body: some View {
    Form {
      Section("SpaceX Launch Lists") {
        ForEach(spaceXLaunchLists, id: \.title) { launchList in
          NavigationLink(
            destination: SpaceXLaunchesView(launchList: launchList)
          ) {
            CircularImageView(color: Color(.red))
            // swiftlint:disable:next force_unwrapping
            Text(launchList.title!)
          }
        }
      }
      Section("Manual Launch Lists") {
        ForEach(launchLists, id: \.self) { launchList in
          NavigationLink(
            destination: LaunchesView(launchList: launchList)
          ) {
            CircularImageView(color: Color(.red))
            // swiftlint:disable:next force_unwrapping
            Text(launchList.title!)
          }
        }
      }
    }
    
  }
}


struct CircularImageView: View {
  var color: Color

  var body: some View {
    VStack {
      Image(systemName: "list.bullet")
        .foregroundColor(.white)
    }
    .padding(12)
    .background(color)
    .clipShape(Circle())
  }
}

struct ListView_Previews: PreviewProvider {
  static var previews: some View {
    let context = PersistenceController.preview.container.viewContext
    return ListView().environment(\.managedObjectContext, context)
  }
}
